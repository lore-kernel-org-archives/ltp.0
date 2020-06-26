From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 Jun 2020 11:10:12 +0200
Subject: [LTP] [PATCH] [COMMITTED] libltpvdso: Fix build on Centos 6
Message-ID: <20200626091012.11960-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since for loop initial declaration are not allowed on old gcc.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 libs/libltpvdso/parse_vdso.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libs/libltpvdso/parse_vdso.c b/libs/libltpvdso/parse_vdso.c
index 03ba47e85..7bbd168b6 100644
--- a/libs/libltpvdso/parse_vdso.c
+++ b/libs/libltpvdso/parse_vdso.c
@@ -232,8 +232,10 @@ void *vdso_sym(const char *version, const char *name)
 
 void vdso_init_from_auxv(void *auxv)
 {
+	int i;
+
 	ELF(auxv_t) *elf_auxv = auxv;
-	for (int i = 0; elf_auxv[i].a_type != AT_NULL; i++) {
+	for (i = 0; elf_auxv[i].a_type != AT_NULL; i++) {
 		if (elf_auxv[i].a_type == AT_SYSINFO_EHDR) {
 			vdso_init_from_sysinfo_ehdr(elf_auxv[i].a_un.a_val);
 			return;
-- 
2.26.2

