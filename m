From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 14 Jul 2021 09:40:03 +0200
Subject: [LTP] [PATCH v2] squashfs: Add regression test for sanity check
 bug
In-Reply-To: <871r81pes4.fsf@suse.de>
References: <20210714055253.1668374-1-lkml@jv-coder.de>
 <871r81pes4.fsf@suse.de>
Message-ID: <dc6520e5-5bc3-b277-c33a-a553632e27a5@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

On 7/14/2021 8:53 AM, Richard Palethorpe wrote:
> Hello Joerg,
>
> Joerg Vehlow <lkml@jv-coder.de> writes:
>
>> + */
>> +
>> +/*\
>> + * [DESCRIPTION]
> I think it is [Description] now.
Both seem to work and there is no documentation for this.
But looks the lower case variant is used more often. Will update this 
for v3.
>
>> + *
>> +
>> +	/* Create squashfs without any comporession.
>> +	 * This allows reasoning about block sizes
>> +	 */
>> +	TST_EXP_PASS(tst_system(
>> +		"mksquashfs data image.raw -noI -noD -noX -noF >/dev/null 2>&1"
> I guess the existing API functions to create an image will not work with
> squashfs?
Honestly I don't know what they are... If it is .format_device stuff, 
then no, this cannot be used
for squashfs, because the data has to be prepared, before the filesystem 
can be created.
>
> At any rate, mksquashfs should be added to .needs_cmds.
Right, forgot about that when converting from shell
>
>> +	), "Create squashfs");
>> +
>> +	SAFE_MKDIR("mnt", 0777);
>> +	TST_EXP_PASS(tst_system("mount -tsquashfs -oloop image.raw
>> mnt"));
> Also why not use safe_mount? I think we have some infra to find a spare
> loop device (.needs_device).
safe_mount would result in TBROK instead of TFAIL. Since mounting is the 
actual test,
a failed mount must be TFAIL.
But TST_EXP_PASS is also not ideal, because it should use tst_brk and 
not tst_res.
Otherwise SAFE_UMOUNT fails with TBROK..
Is there some other api function or do I have to implement the return 
value check myself?

Here is the diff for using needs_device:
diff --git a/testcases/kernel/fs/squashfs/squashfs_regression.c 
b/testcases/kernel/fs/squashfs/squashfs_regression.c
index 23f681367..affba8069 100644
--- a/testcases/kernel/fs/squashfs/squashfs_regression.c
+++ b/testcases/kernel/fs/squashfs/squashfs_regression.c
@@ -44,6 +44,7 @@ static void cleanup(void)
 ?static void run(void)
 ?{
 ???? int i;
+??? char cmd[1024];

 ???? tst_res(TINFO, "Test squashfs sanity check regressions");

@@ -66,15 +67,17 @@ static void run(void)
 ???? ??? close(fd);
 ???? }

-??? /* Create squashfs without any comporession.
-??? ?* This allows reasoning about block sizes
+??? /* Create squashfs without any compression.
+??? ?* This allows reasoning about block sizes.
+??? ?* Redirect stdout, to get rid of undefined uid messages
 ???? ?*/
-??? TST_EXP_PASS(tst_system(
-??? ??? "mksquashfs data image.raw -noI -noD -noX -noF >/dev/null 2>&1"
-??? ), "Create squashfs");
+??? sprintf(cmd,
+??? ??????? "mksquashfs data %s -noI -noD -noX -noF -noappend >/dev/null",
+??? ??? ??? tst_device->dev);
+??? TST_EXP_PASS(tst_system(cmd), "Create squashfs");

 ???? SAFE_MKDIR("mnt", 0777);
-??? TST_EXP_PASS(tst_system("mount -tsquashfs -oloop image.raw mnt"));
+??? TST_EXP_PASS(mount(tst_device->dev, "mnt", "squashfs", 0, NULL));

 ???? SAFE_UMOUNT("mnt");

@@ -85,9 +88,14 @@ static struct tst_test test = {
 ???? .test_all = run,
 ???? .cleanup = cleanup,
 ???? .needs_root = 1,
+??? .needs_device = 1,
+??? .dev_min_size = 1,
+??? .needs_cmds = (const char *const []) {
+??? ??? "mksquashfs",
+??? ??? NULL
+??? },
 ???? .needs_drivers = (const char *const []) {
 ???? ??? "squashfs",
-??? ??? "loop",
 ???? ??? NULL
 ???? },
 ???? .tags = (const struct tst_tag[]) {


Joerg
