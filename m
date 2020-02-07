From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 7 Feb 2020 15:04:46 +0100
Subject: [LTP] [PATCH 1/1] syscalls/fsmount01: Add test for new mount
 API v5.2
In-Reply-To: <20200207132001.GC19508@rei.lan>
References: <20200206162722.18945-1-pvorel@suse.cz>
 <20200207132001.GC19508@rei.lan>
Message-ID: <20200207140404.GA8492@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > +	while (fgets(line, LINELENGTH, file) != NULL) {
> > +		if (strstr(line, mntpoint) != NULL) {

> It's not necessary to check against NULL, we can simply write these as:

> 	while (fgets(line, sizeof(line), file)) {
> 		...

> > +			ret = 1;
> > +			break;
> > +		}
> > +	}
> > +	SAFE_FCLOSE(file);
> > +	return ret;
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	if (is_mounted) {
> > +		TEST(tst_umount(MNTPOINT));
> > +		if (TST_RET != 0)
> > +			tst_brk(TBROK | TTERRNO, "umount failed in cleanup");

> I do remmeber commenting this that the tst_umount() already prints a
> WARN which will fail the test anyways, so there is no point in handling
> the return from tst_umount() here.
I guess SAFE_UMOUNT(MNTPOINT) will be the best.

...
> > +	if (ismount(MNTPOINT)) {
> > +		tst_res(TPASS, "new mount API from v5.2 works");
> > +		TEST(tst_umount(MNTPOINT));
> > +		if (TST_RET != 0)
> > +			tst_brk(TBROK | TTERRNO, "umount failed");

> And here as well.

> Apart from these two minor comments the test looks good, you can add my
> Reviewed-by.

Thanks for review, sorry for not catching these errors.
Going to fix it with your Reviewed-by, with these fixes.

Kind regards,
Petr

diff --git testcases/kernel/syscalls/fsmount/fsmount01.c testcases/kernel/syscalls/fsmount/fsmount01.c
index 7ba50753f..64e8c4744 100644
--- testcases/kernel/syscalls/fsmount/fsmount01.c
+++ testcases/kernel/syscalls/fsmount/fsmount01.c
@@ -25,7 +25,7 @@ static int ismount(char *mntpoint)
 
 	file = SAFE_FOPEN("/proc/mounts", "r");
 
-	while (fgets(line, LINELENGTH, file) != NULL) {
+	while (fgets(line, sizeof(line), file)) {
 		if (strstr(line, mntpoint) != NULL) {
 			ret = 1;
 			break;
@@ -37,11 +37,8 @@ static int ismount(char *mntpoint)
 
 static void cleanup(void)
 {
-	if (is_mounted) {
-		TEST(tst_umount(MNTPOINT));
-		if (TST_RET != 0)
-			tst_brk(TBROK | TTERRNO, "umount failed in cleanup");
-	}
+	if (is_mounted)
+		SAFE_UMOUNT(MNTPOINT)
 }
 
 static void test_newmount(void)
@@ -80,9 +77,7 @@ static void test_newmount(void)
 
 	if (ismount(MNTPOINT)) {
 		tst_res(TPASS, "new mount API from v5.2 works");
-		TEST(tst_umount(MNTPOINT));
-		if (TST_RET != 0)
-			tst_brk(TBROK | TTERRNO, "umount failed");
+		SAFE_UMOUNT(MNTPOINT)
 		is_mounted = 0;
 	} else
 		tst_res(TFAIL, "new mount API from v5.2 works");
