# 라이너스 직무기술서 — 배포 가이드

## 준비물
- Supabase 계정 (무료) → https://supabase.com
- Vercel 계정 (무료) → https://vercel.com
- GitHub 계정 (무료) → https://github.com

---

## Step 1. Supabase 프로젝트 생성

1. https://supabase.com 접속 → **New Project**
2. 프로젝트 이름: `linus-jd` (아무거나 OK)
3. DB 비밀번호 설정 (기억 안 해도 됨)
4. Region: **Northeast Asia (Seoul)** 선택
5. 생성 완료까지 약 1분 대기

---

## Step 2. DB 테이블 생성

1. Supabase 대시보드 → 좌측 **SQL Editor** 클릭
2. `schema.sql` 파일 내용 전체 복사 → 붙여넣기 → **Run** 클릭
3. 오류 없이 완료되면 OK


---

## Step 2-1. 팀원 계정 등록 (로그인용)

1. Supabase 대시보드 → 좌측 **Authentication → Users**
2. **Add User → Create New User** 클릭
3. 팀원 이메일 + 임시 비밀번호 입력 → **Create User**
4. 팀원에게 이메일 + 비밀번호 전달 (첫 로그인 후 비밀번호 변경 안내)

> 💡 팀원이 추가/퇴사할 때도 여기서 계정 관리

---

## Step 3. API 키 복사

1. Supabase 대시보드 → 좌측 **Settings → API**
2. 다음 두 값을 복사해둠:
   - **Project URL** (예: `https://abcdefgh.supabase.co`)
   - **anon public** 키 (긴 문자열)

---

## Step 4. index.html 키 입력

`index.html` 파일 상단 아래 부분을 수정:

```js
const SUPABASE_URL  = 'https://YOUR_PROJECT.supabase.co';  // ← Project URL
const SUPABASE_KEY  = 'YOUR_ANON_KEY';                     // ← anon public 키
```

---

## Step 5. GitHub에 올리기

```bash
# 터미널에서
git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/계정명/linus-jd.git
git push -u origin main
```

또는 GitHub Desktop으로 해도 됨.

---

## Step 6. Vercel 배포

1. https://vercel.com 접속 → **Add New Project**
2. GitHub 연결 → `linus-jd` 저장소 선택
3. **Framework Preset**: `Other` 선택
4. **Deploy** 클릭
5. 배포 완료 후 자동으로 주소 생성됨:
   ```
   https://linus-jd.vercel.app
   ```

이 주소를 팀원들에게 공유하면 됨. 끝!

---

## 이후 수정 시

`index.html` 파일 수정 후 GitHub에 push하면 Vercel이 자동으로 재배포함.

```bash
git add .
git commit -m "수정 내용"
git push
```

---

## 폴더 구조

```
linus-jd/
├── index.html   ← 앱 전체 (수정 필요: Supabase URL/KEY)
├── schema.sql   ← DB 테이블 생성 쿼리 (Step 2에서 1회 실행)
└── README.md    ← 이 파일
```
# linus-project-management
# linus-project-management
# linus-project-management
