Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Xsv1Q-0002dR-47
	for ltp-list@lists.sourceforge.net; Mon, 24 Nov 2014 14:53:48 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xsv1O-0001kr-5o
	for ltp-list@lists.sourceforge.net; Mon, 24 Nov 2014 14:53:48 +0000
Message-ID: <5473466C.2070409@oracle.com>
Date: Mon, 24 Nov 2014 17:53:32 +0300
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <20141031133917.GA3195@localhost.localdomain>
	<54608048.4000201@oracle.com>
	<20141113075747.GA19392@localhost.localdomain>
	<546C51BA.5060304@oracle.com>
	<20141121075923.GA2804@localhost.localdomain>
In-Reply-To: <20141121075923.GA2804@localhost.localdomain>
Subject: Re: [LTP] [PATCH] fix some syscall tests for 16-bit compat testing
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Hi.

In general, it looks good.

I have only one comment, that it's possible that the uid/gid values we 
pass to the syscall may not fit into UID_T/GID_T. For example, when we 
get uid of nobody user in runtime and pass it to chown() or etc.

Yes, it's more like an artificial case, but it's.

We have UID16_CHECK and GID16_CHECK macros to check if the uid/gid fits 
the compat mode.

What do you think about using it in test cases chown01, chown03, 
chown04, fchown01, fchown03, fchown04, setresgid*, setresuid* ?

Thank you.


On 11/21/2014 10:59 AM, Han Pingtian wrote:
> On Wed, Nov 19, 2014 at 11:15:54AM +0300, Stanislav Kholmanskikh wrote:
>>> Looks like those cases need to be fixed for the 16-bit compat, right?
>>>
>>> chown0[1-5] fchown0[1-5] lchown03 setresgid0[1-4] setresuid0[1-3,5]
>>
>> Looks so.
>>
>> Sorry for the late response.
>>
>
> I have composed a patch, please take a look. Thanks
>
>  From 71f5463f414e55d609603905e3f20b1f0eac2226 Mon Sep 17 00:00:00 2001
> From: Han Pingtian <hanpt@linux.vnet.ibm.com>
> Date: Fri, 21 Nov 2014 15:50:23 +0800
> Subject: [PATCH] fix some syscall tests for 16-bit compat testing
>
> Some syscall test cases have been compiled for 16-bit compat testing,
> but doesn't change the code yet. This fix try to add proper code to let
> them support this testing.
>
> Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
> ---
>   testcases/kernel/syscalls/chown/chown01.c         |  3 ++-
>   testcases/kernel/syscalls/chown/chown02.c         |  3 ++-
>   testcases/kernel/syscalls/chown/chown03.c         |  3 ++-
>   testcases/kernel/syscalls/chown/chown04.c         |  3 ++-
>   testcases/kernel/syscalls/chown/chown05.c         |  3 ++-
>   testcases/kernel/syscalls/fchown/fchown01.c       |  3 ++-
>   testcases/kernel/syscalls/fchown/fchown02.c       |  3 ++-
>   testcases/kernel/syscalls/fchown/fchown03.c       |  3 ++-
>   testcases/kernel/syscalls/fchown/fchown04.c       |  3 ++-
>   testcases/kernel/syscalls/fchown/fchown05.c       |  3 ++-
>   testcases/kernel/syscalls/lchown/lchown03.c       |  3 ++-
>   testcases/kernel/syscalls/setresgid/setresgid01.c |  3 ++-
>   testcases/kernel/syscalls/setresgid/setresgid02.c |  3 ++-
>   testcases/kernel/syscalls/setresgid/setresgid03.c |  3 ++-
>   testcases/kernel/syscalls/setresgid/setresgid04.c |  3 ++-
>   testcases/kernel/syscalls/setresuid/setresuid01.c |  3 ++-
>   testcases/kernel/syscalls/setresuid/setresuid02.c |  3 ++-
>   testcases/kernel/syscalls/setresuid/setresuid03.c |  2 +-
>   testcases/kernel/syscalls/setresuid/setresuid04.c |  9 +++++----
>   testcases/kernel/syscalls/setresuid/setresuid05.c |  3 ++-
>   testcases/kernel/syscalls/utils/compat_16.h       | 20 ++++++++++++++++++++
>   21 files changed, 62 insertions(+), 23 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/chown/chown01.c b/testcases/kernel/syscalls/chown/chown01.c
> index ef728e1..5cf33dc 100644
> --- a/testcases/kernel/syscalls/chown/chown01.c
> +++ b/testcases/kernel/syscalls/chown/chown01.c
> @@ -117,6 +117,7 @@
>   #include "test.h"
>   #include "usctest.h"
>   #include "safe_macros.h"
> +#include "compat_16.h"
>
>   char *TCID = "chown01";
>   int TST_TOTAL = 1;
> @@ -145,7 +146,7 @@ int main(int ac, char **av)
>
>   		tst_count = 0;
>
> -		TEST(chown(fname, uid, gid));
> +		TEST(CHOWN(cleanup, fname, uid, gid));
>
>   		if (TEST_RETURN == -1) {
>   			tst_resm(TFAIL | TTERRNO, "chown(%s, %d,%d) failed",
> diff --git a/testcases/kernel/syscalls/chown/chown02.c b/testcases/kernel/syscalls/chown/chown02.c
> index 339b2e8..30394ec 100644
> --- a/testcases/kernel/syscalls/chown/chown02.c
> +++ b/testcases/kernel/syscalls/chown/chown02.c
> @@ -79,6 +79,7 @@
>
>   #include "test.h"
>   #include "usctest.h"
> +#include "compat_16.h"
>
>   #define FILE_MODE	(S_IFREG|S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
>   #define NEW_PERMS1	(S_IFREG|S_IRWXU|S_IRWXG|S_ISUID|S_ISGID)
> @@ -142,7 +143,7 @@ int main(int ac, char **av)
>   			 * Call chown(2) with different user id and
>   			 * group id (numeric values) to set it on testfile.
>   			 */
> -			TEST(chown(file_name, user_id, group_id));
> +			TEST(CHOWN(cleanup, file_name, user_id, group_id));
>
>   			if (TEST_RETURN == -1) {
>   				tst_resm(TFAIL | TTERRNO,
> diff --git a/testcases/kernel/syscalls/chown/chown03.c b/testcases/kernel/syscalls/chown/chown03.c
> index 9780c2f..0ed4c91 100644
> --- a/testcases/kernel/syscalls/chown/chown03.c
> +++ b/testcases/kernel/syscalls/chown/chown03.c
> @@ -82,6 +82,7 @@
>
>   #include "test.h"
>   #include "usctest.h"
> +#include "compat_16.h"
>
>   #define FILE_MODE	(S_IFREG|S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
>   #define NEW_PERMS	(S_IFREG|S_IRWXU|S_IRWXG|S_ISUID|S_ISGID)
> @@ -115,7 +116,7 @@ int main(int ac, char **av)
>   		user_id = geteuid();
>   		group_id = getegid();
>
> -		TEST(chown(TESTFILE, -1, group_id));
> +		TEST(CHOWN(cleanup, TESTFILE, -1, group_id));
>
>   		if (TEST_RETURN == -1) {
>   			tst_resm(TFAIL | TTERRNO, "chown(%s, ..) failed",
> diff --git a/testcases/kernel/syscalls/chown/chown04.c b/testcases/kernel/syscalls/chown/chown04.c
> index 1459227..b07dfa8 100644
> --- a/testcases/kernel/syscalls/chown/chown04.c
> +++ b/testcases/kernel/syscalls/chown/chown04.c
> @@ -55,6 +55,7 @@
>   #include "test.h"
>   #include "usctest.h"
>   #include "safe_macros.h"
> +#include "compat_16.h"
>
>   #define MODE_RWX		 (S_IRWXU|S_IRWXG|S_IRWXO)
>   #define FILE_MODE		 (S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
> @@ -118,7 +119,7 @@ int main(int ac, char **av)
>   		tst_count = 0;
>
>   		for (i = 0; i < TST_TOTAL; i++) {
> -			TEST(chown(tc[i].pathname, user_id, group_id));
> +			TEST(CHOWN(cleanup, tc[i].pathname, user_id, group_id));
>
>   			if (TEST_RETURN == 0) {
>   				tst_resm(TFAIL, "chown succeeded unexpectedly");
> diff --git a/testcases/kernel/syscalls/chown/chown05.c b/testcases/kernel/syscalls/chown/chown05.c
> index 92e1811..3ec4f13 100644
> --- a/testcases/kernel/syscalls/chown/chown05.c
> +++ b/testcases/kernel/syscalls/chown/chown05.c
> @@ -77,6 +77,7 @@
>
>   #include "test.h"
>   #include "usctest.h"
> +#include "compat_16.h"
>
>   #define FILE_MODE	(S_IFREG|S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
>   #define TESTFILE	"testfile"
> @@ -121,7 +122,7 @@ int main(int ac, char **av)
>   			user_id = test_cases[i].user_id;
>   			group_id = test_cases[i].group_id;
>
> -			TEST(chown(TESTFILE, user_id, group_id));
> +			TEST(CHOWN(cleanup, TESTFILE, user_id, group_id));
>
>   			if (TEST_RETURN == -1) {
>   				tst_resm(TFAIL | TTERRNO, "chown failed");
> diff --git a/testcases/kernel/syscalls/fchown/fchown01.c b/testcases/kernel/syscalls/fchown/fchown01.c
> index be620d7..841e02b 100644
> --- a/testcases/kernel/syscalls/fchown/fchown01.c
> +++ b/testcases/kernel/syscalls/fchown/fchown01.c
> @@ -42,6 +42,7 @@
>   #include "test.h"
>   #include "usctest.h"
>   #include "safe_macros.h"
> +#include "compat_16.h"
>
>   static void setup(void);
>   static void cleanup(void);
> @@ -65,7 +66,7 @@ int main(int ac, char **av)
>
>   		tst_count = 0;
>
> -		TEST(fchown(fd, geteuid(), getegid()));
> +		TEST(FCHOWN(cleanup, fd, geteuid(), getegid()));
>
>   		if (TEST_RETURN == -1) {
>   			tst_resm(TFAIL | TTERRNO, "fchown failed");
> diff --git a/testcases/kernel/syscalls/fchown/fchown02.c b/testcases/kernel/syscalls/fchown/fchown02.c
> index fd14ba1..0c1782d 100644
> --- a/testcases/kernel/syscalls/fchown/fchown02.c
> +++ b/testcases/kernel/syscalls/fchown/fchown02.c
> @@ -38,6 +38,7 @@
>   #include "test.h"
>   #include "usctest.h"
>   #include "safe_macros.h"
> +#include "compat_16.h"
>
>   #define FILE_MODE	S_IFREG | S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
>   #define NEW_PERMS1	S_IFREG | S_IRWXU | S_IRWXG | S_ISUID | S_ISGID
> @@ -71,7 +72,7 @@ static void verify_fchown(struct test_case *t)
>   {
>   	struct stat stat_buf;
>
> -	TEST(fchown(*t->fd, t->user_id, t->group_id));
> +	TEST(FCHOWN(cleanup, *t->fd, t->user_id, t->group_id));
>
>   	if (TEST_RETURN == -1) {
>   		tst_resm(TFAIL | TTERRNO, "fchown() Fails on %s", t->pathname);
> diff --git a/testcases/kernel/syscalls/fchown/fchown03.c b/testcases/kernel/syscalls/fchown/fchown03.c
> index 3a75093..d0218b2 100644
> --- a/testcases/kernel/syscalls/fchown/fchown03.c
> +++ b/testcases/kernel/syscalls/fchown/fchown03.c
> @@ -41,6 +41,7 @@
>   #include "test.h"
>   #include "usctest.h"
>   #include "safe_macros.h"
> +#include "compat_16.h"
>
>   #define FILE_MODE (mode_t)(S_IFREG | S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)
>   #define NEW_PERMS (mode_t)(S_IFREG | S_IRWXU | S_IRWXG | S_ISUID | S_ISGID)
> @@ -77,7 +78,7 @@ int main(int ac, char **av)
>   		user_id = geteuid();
>   		group_id = getegid();
>
> -		TEST(fchown(fildes, -1, group_id));
> +		TEST(FCHOWN(cleanup, fildes, -1, group_id));
>
>   		if (TEST_RETURN == -1) {
>   			tst_resm(TFAIL, "fchown() on %s Fails, errno=%d",
> diff --git a/testcases/kernel/syscalls/fchown/fchown04.c b/testcases/kernel/syscalls/fchown/fchown04.c
> index 0829944..6dec6cb 100644
> --- a/testcases/kernel/syscalls/fchown/fchown04.c
> +++ b/testcases/kernel/syscalls/fchown/fchown04.c
> @@ -45,6 +45,7 @@
>   #include "test.h"
>   #include "usctest.h"
>   #include "safe_macros.h"
> +#include "compat_16.h"
>
>   #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
>   			 S_IXGRP|S_IROTH|S_IXOTH)
> @@ -140,7 +141,7 @@ static void setup(void)
>
>   static void fchown_verify(int i)
>   {
> -	TEST(fchown(*test_cases[i].fd, geteuid(), getegid()));
> +	TEST(FCHOWN(cleanup, *test_cases[i].fd, geteuid(), getegid()));
>
>   	if (TEST_RETURN == -1) {
>   		if (TEST_ERRNO == test_cases[i].exp_errno) {
> diff --git a/testcases/kernel/syscalls/fchown/fchown05.c b/testcases/kernel/syscalls/fchown/fchown05.c
> index 67a745a..47d5b00 100644
> --- a/testcases/kernel/syscalls/fchown/fchown05.c
> +++ b/testcases/kernel/syscalls/fchown/fchown05.c
> @@ -34,6 +34,7 @@
>   #include "test.h"
>   #include "usctest.h"
>   #include "safe_macros.h"
> +#include "compat_16.h"
>
>   #define FILE_MODE	S_IFREG | S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
>   #define TESTFILE	"testfile"
> @@ -80,7 +81,7 @@ int main(int ac, char **av)
>   			user_id = tc[i].user_id;
>   			group_id = tc[i].group_id;
>
> -			TEST(fchown(fildes, user_id, group_id));
> +			TEST(FCHOWN(cleanup, fildes, user_id, group_id));
>
>   			if (TEST_RETURN == -1) {
>   				tst_resm(TFAIL | TTERRNO,
> diff --git a/testcases/kernel/syscalls/lchown/lchown03.c b/testcases/kernel/syscalls/lchown/lchown03.c
> index 9e4d6f9..8624728 100644
> --- a/testcases/kernel/syscalls/lchown/lchown03.c
> +++ b/testcases/kernel/syscalls/lchown/lchown03.c
> @@ -40,6 +40,7 @@
>   #include "test.h"
>   #include "usctest.h"
>   #include "safe_macros.h"
> +#include "compat_16.h"
>
>   #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
>   			 S_IXGRP|S_IROTH|S_IXOTH)
> @@ -124,7 +125,7 @@ static void setup(void)
>
>   static void lchown_verify(const struct test_case_t *test)
>   {
> -	TEST(lchown(test->pathname, geteuid(), getegid()));
> +	TEST(LCHOWN(cleanup, test->pathname, geteuid(), getegid()));
>
>   	if (TEST_RETURN != -1) {
>   		tst_resm(TFAIL, "lchown() returned %ld, expected -1, errno=%d",
> diff --git a/testcases/kernel/syscalls/setresgid/setresgid01.c b/testcases/kernel/syscalls/setresgid/setresgid01.c
> index f9c62a0..db3b9dc 100644
> --- a/testcases/kernel/syscalls/setresgid/setresgid01.c
> +++ b/testcases/kernel/syscalls/setresgid/setresgid01.c
> @@ -76,6 +76,7 @@
>   #include <unistd.h>
>   #include "test.h"
>   #include "usctest.h"
> +#include "compat_16.h"
>
>   #define EXP_RET_VAL	0
>
> @@ -131,7 +132,7 @@ int main(int argc, char **argv)
>
>   		for (testno = 0; testno < TST_TOTAL; ++testno) {
>
> -			TEST(setresgid(*tdat[testno].rgid, *tdat[testno].egid,
> +			TEST(SETRESGID(cleanup, *tdat[testno].rgid, *tdat[testno].egid,
>   				       *tdat[testno].sgid));
>
>   			if (TEST_RETURN == EXP_RET_VAL) {
> diff --git a/testcases/kernel/syscalls/setresgid/setresgid02.c b/testcases/kernel/syscalls/setresgid/setresgid02.c
> index 754fca1..e0c935d 100644
> --- a/testcases/kernel/syscalls/setresgid/setresgid02.c
> +++ b/testcases/kernel/syscalls/setresgid/setresgid02.c
> @@ -81,6 +81,7 @@
>   #include <unistd.h>
>   #include "test.h"
>   #include "usctest.h"
> +#include "compat_16.h"
>
>   #define EXP_RET_VAL	0
>
> @@ -138,7 +139,7 @@ int main(int argc, char **argv)
>
>   		for (testno = 0; testno < TST_TOTAL; ++testno) {
>
> -			TEST(setresgid(*tdat[testno].rgid, *tdat[testno].egid,
> +			TEST(SETRESGID(cleanup, *tdat[testno].rgid, *tdat[testno].egid,
>   				       *tdat[testno].sgid));
>
>   			if (TEST_RETURN == EXP_RET_VAL) {
> diff --git a/testcases/kernel/syscalls/setresgid/setresgid03.c b/testcases/kernel/syscalls/setresgid/setresgid03.c
> index 32d7995..0e9801e 100644
> --- a/testcases/kernel/syscalls/setresgid/setresgid03.c
> +++ b/testcases/kernel/syscalls/setresgid/setresgid03.c
> @@ -81,6 +81,7 @@
>   #include <unistd.h>
>   #include "test.h"
>   #include "usctest.h"
> +#include "compat_16.h"
>
>   #define EXP_RET_VAL	-1
>   #define EXP_ERRNO	EPERM
> @@ -131,7 +132,7 @@ int main(int argc, char **argv)
>
>   		for (testno = 0; testno < TST_TOTAL; ++testno) {
>
> -			TEST(setresgid(*tdat[testno].rgid, *tdat[testno].egid,
> +			TEST(SETRESGID(cleanup, *tdat[testno].rgid, *tdat[testno].egid,
>   				       *tdat[testno].sgid));
>
>   			TEST_ERROR_LOG(TEST_ERRNO);
> diff --git a/testcases/kernel/syscalls/setresgid/setresgid04.c b/testcases/kernel/syscalls/setresgid/setresgid04.c
> index 4e71910..cc481ce 100644
> --- a/testcases/kernel/syscalls/setresgid/setresgid04.c
> +++ b/testcases/kernel/syscalls/setresgid/setresgid04.c
> @@ -30,6 +30,7 @@
>   #include "test.h"
>   #include "usctest.h"
>   #include "safe_macros.h"
> +#include "compat_16.h"
>
>   char *TCID = "setresgid04";
>   int TST_TOTAL = 1;
> @@ -76,7 +77,7 @@ static void setresgid_verify(void)
>   {
>   	struct stat buf;
>
> -	TEST(setresgid(-1, ltpuser->pw_gid, -1));
> +	TEST(SETRESGID(cleanup, -1, ltpuser->pw_gid, -1));
>
>   	if (TEST_RETURN != 0) {
>   		tst_resm(TFAIL | TTERRNO, "setresgid failed unexpectedly");
> diff --git a/testcases/kernel/syscalls/setresuid/setresuid01.c b/testcases/kernel/syscalls/setresuid/setresuid01.c
> index 39e1ac3..49211c1 100644
> --- a/testcases/kernel/syscalls/setresuid/setresuid01.c
> +++ b/testcases/kernel/syscalls/setresuid/setresuid01.c
> @@ -69,6 +69,7 @@
>   #include "test.h"
>   #include "usctest.h"
>   #include <errno.h>
> +#include "compat_16.h"
>
>   char *TCID = "setresuid01";
>
> @@ -140,7 +141,7 @@ int main(int ac, char **av)
>
>   		for (i = 0; i < TST_TOTAL; i++) {
>   			/* Set the real, effective or user id */
> -			TEST(setresuid(*test_data[i].real_uid,
> +			TEST(SETRESUID(cleanup, *test_data[i].real_uid,
>   				       *test_data[i].eff_uid,
>   				       *test_data[i].sav_uid));
>
> diff --git a/testcases/kernel/syscalls/setresuid/setresuid02.c b/testcases/kernel/syscalls/setresuid/setresuid02.c
> index 0837c9e..5e1b7fd 100644
> --- a/testcases/kernel/syscalls/setresuid/setresuid02.c
> +++ b/testcases/kernel/syscalls/setresuid/setresuid02.c
> @@ -65,6 +65,7 @@
>   #include "usctest.h"
>   #include <errno.h>
>   #include <sys/wait.h>
> +#include "compat_16.h"
>
>   char *TCID = "setresuid02";
>
> @@ -140,7 +141,7 @@ int main(int ac, char **av)
>   			for (i = 0; i < TST_TOTAL; i++) {
>
>   				/* Set the real, effective or saved user id */
> -				TEST(setresuid(*test_data[i].real_uid,
> +				TEST(SETRESUID(cleanup, *test_data[i].real_uid,
>   					       *test_data[i].eff_uid,
>   					       *test_data[i].sav_uid));
>
> diff --git a/testcases/kernel/syscalls/setresuid/setresuid03.c b/testcases/kernel/syscalls/setresuid/setresuid03.c
> index f624253..592c764 100644
> --- a/testcases/kernel/syscalls/setresuid/setresuid03.c
> +++ b/testcases/kernel/syscalls/setresuid/setresuid03.c
> @@ -150,7 +150,7 @@ int main(int ac, char **av)
>   			for (i = 0; i < TST_TOTAL; i++) {
>
>   				/* Set the real, effective or saved user id */
> -				TEST(setresuid(*test_data[i].real_uid,
> +				TEST(SETRESUID(cleanup, *test_data[i].real_uid,
>   					       *test_data[i].eff_uid,
>   					       *test_data[i].sav_uid));
>
> diff --git a/testcases/kernel/syscalls/setresuid/setresuid04.c b/testcases/kernel/syscalls/setresuid/setresuid04.c
> index 140d5f3..dfc9058 100644
> --- a/testcases/kernel/syscalls/setresuid/setresuid04.c
> +++ b/testcases/kernel/syscalls/setresuid/setresuid04.c
> @@ -53,6 +53,7 @@
>   #include "test.h"
>   #include "usctest.h"
>   #include <pwd.h>
> +#include "compat_16.h"
>
>   char *TCID = "setresuid04";
>   int TST_TOTAL = 1;
> @@ -111,8 +112,8 @@ void do_master_child(void)
>   		/* Reset tst_count in case we are looping */
>   		tst_count = 0;
>
> -		if (setresuid(0, ltpuser->pw_uid, 0) == -1) {
> -			perror("setfsuid failed");
> +		if (SETRESUID(cleanup, 0, ltpuser->pw_uid, 0) == -1) {
> +			perror("setresuid failed");
>   			exit(1);
>   		}
>
> @@ -176,8 +177,8 @@ void do_master_child(void)
>   		 *         the file with RDWR permissions.
>   		 */
>   		tst_count++;
> -		if (setresuid(0, 0, 0) == -1) {
> -			perror("setfsuid failed");
> +		if (SETRESUID(cleanup, 0, 0, 0) == -1) {
> +			perror("setresuid failed");
>   			exit(1);
>   		}
>
> diff --git a/testcases/kernel/syscalls/setresuid/setresuid05.c b/testcases/kernel/syscalls/setresuid/setresuid05.c
> index 8880aeb..44d1565 100644
> --- a/testcases/kernel/syscalls/setresuid/setresuid05.c
> +++ b/testcases/kernel/syscalls/setresuid/setresuid05.c
> @@ -30,6 +30,7 @@
>   #include "test.h"
>   #include "usctest.h"
>   #include "safe_macros.h"
> +#include "compat_16.h"
>
>   char *TCID = "setresuid05";
>   int TST_TOTAL = 1;
> @@ -76,7 +77,7 @@ static void setresuid_verify(void)
>   {
>   	struct stat buf;
>
> -	TEST(setresuid(-1, ltpuser->pw_uid, -1));
> +	TEST(SETRESUID(cleanup, -1, ltpuser->pw_uid, -1));
>
>   	if (TEST_RETURN != 0) {
>   		tst_resm(TFAIL | TTERRNO, "setresuid failed unexpectedly");
> diff --git a/testcases/kernel/syscalls/utils/compat_16.h b/testcases/kernel/syscalls/utils/compat_16.h
> index 40bef59..b6a702d 100644
> --- a/testcases/kernel/syscalls/utils/compat_16.h
> +++ b/testcases/kernel/syscalls/utils/compat_16.h
> @@ -127,8 +127,28 @@ int SETREGID(void (cleanup)(void), GID_T rgid, GID_T egid)
>   	LTP_CREATE_SYSCALL(setregid, cleanup, rgid, egid);
>   }
>
> +int SETRESUID(void (cleanup)(void), UID_T ruid, UID_T euid, UID_T suid)
> +{
> +	LTP_CREATE_SYSCALL(setresuid, cleanup, ruid, euid, suid);
> +}
> +
> +int SETRESGID(void (cleanup)(void), GID_T rgid, GID_T egid, GID_T sgid)
> +{
> +	LTP_CREATE_SYSCALL(setresgid, cleanup, rgid, egid, sgid);
> +}
> +
> +int FCHOWN(void (cleanup)(void), unsigned int fd, UID_T owner, GID_T group)
> +{
> +	LTP_CREATE_SYSCALL(fchown, cleanup, fd, owner, group);
> +}
> +
>   int LCHOWN(void (cleanup)(void), const char *path, UID_T owner, GID_T group)
>   {
>   	LTP_CREATE_SYSCALL(lchown, cleanup, path, owner, group);
>   }
> +
> +int CHOWN(void (cleanup)(void), const char *path, UID_T owner, GID_T group)
> +{
> +	LTP_CREATE_SYSCALL(chown, cleanup, path, owner, group);
> +}
>   #endif /* __LTP_COMPAT_16_H__ */
>

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
