-- 라이너스 직무기술서 DB 스키마
-- Supabase SQL Editor에서 순서대로 실행하세요

-- 1. 프로젝트 테이블
create table if not exists projects (
  id text primary key,
  name text not null,
  created_at timestamptz default now()
);

-- 2. 체크박스 상태 테이블
create table if not exists task_checks (
  id bigserial primary key,
  project_id text not null references projects(id) on delete cascade,
  proc_id text not null,
  task_index int not null,
  checked boolean default false,
  updated_at timestamptz default now(),
  unique(project_id, proc_id, task_index)
);

-- 3. 산출물 첨부파일/링크 테이블
create table if not exists output_attachments (
  id bigserial primary key,
  project_id text not null references projects(id) on delete cascade,
  proc_id text not null,
  output_index int not null,
  url text,
  label text,
  type text,
  updated_at timestamptz default now(),
  unique(project_id, proc_id, output_index)
);

-- 4. RLS 비활성화 (사내 내부 툴이므로 퍼블릭 접근 허용)
alter table projects enable row level security;
alter table task_checks enable row level security;
alter table output_attachments enable row level security;

create policy "public_all" on projects for all using (true) with check (true);
create policy "public_all" on task_checks for all using (true) with check (true);
create policy "public_all" on output_attachments for all using (true) with check (true);

-- 5. Storage 버킷 생성 (파일 업로드용)
insert into storage.buckets (id, name, public)
values ('outputs', 'outputs', true)
on conflict do nothing;

-- 버킷 접근 정책 (로그인한 사용자만 업로드/조회)
create policy "auth_read" on storage.objects for select using (bucket_id = 'outputs' and auth.role() = 'authenticated');
create policy "auth_upload" on storage.objects for insert with check (bucket_id = 'outputs' and auth.role() = 'authenticated');
create policy "auth_delete" on storage.objects for delete using (bucket_id = 'outputs' and auth.role() = 'authenticated');
