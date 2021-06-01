From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Tue,  1 Jun 2021 13:54:53 +0200
Subject: [LTP] [PATCH v2 1/1] tst_wallclock_restore: fix access time of
 /etc/localtime
Message-ID: <20210601115453.458069-1-egorenar@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test clock_settime03 temporarily changes the wallclock to a date in
the year 2038. This has a negative side-effect of changing the access time
of the time zone file to which /etc/localtime refers.

This causes a nasty issue with glibc-2.33 for applications built with -m32
compiler flag. An access time from the year 2038 leads to an overflow error
in glibc-2.33 in
* https://elixir.bootlin.com/glibc/glibc-2.33/source/time/tzfile.c#L167
* https://elixir.bootlin.com/glibc/glibc-2.33/source/sysdeps/unix/sysv/linux/stat_t64_cp.c#L29
when a call to localtime() is made in 32bit mode.

This issue causes e.g. some of strace 32-bit tests to fail because they use
localtime() in 32-bit mode (reproducible on s390x) when we execute it after
the LTP test suite.

To fix this issue, touch the /etc/localtime after the wallclock was
restored.

Test on x86_64 Fedora 34
------------------------
$ stat /usr/share/zoneinfo/Europe/Berlin
  File: /usr/share/zoneinfo/Europe/Berlin
  Size: 2298            Blocks: 8          IO Block: 4096   regular file
Device: fd01h/64769d    Inode: 2623067     Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Context: system_u:object_r:locale_t:s0
Access: 2021-06-01 11:10:14.341921070 +0200   <---- watch this !!!
Modify: 2021-06-01 11:10:14.192920508 +0200
Change: 2021-06-01 11:10:14.192920508 +0200
 Birth: 2021-04-28 22:06:08.389017197 +0200

$ sudo ./clock_settime03
tst_test.c:1311: TINFO: Timeout per run is 0h 05m 00s
clock_settime03.c:35: TINFO: Testing variant: syscall with old kernel spec
clock_settime03.c:103: TPASS: clock_settime(): Y2038 test passed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0

$ stat /usr/share/zoneinfo/Europe/Berlin
  File: /usr/share/zoneinfo/Europe/Berlin
  Size: 2298            Blocks: 8          IO Block: 4096   regular file
Device: fd01h/64769d    Inode: 2623067     Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Context: system_u:object_r:locale_t:s0
Access: 2038-01-19 04:14:06.067000237 +0100   <---- watch this !!!
Modify: 2021-06-01 11:10:14.192920508 +0200
Change: 2021-06-01 11:10:14.192920508 +0200
 Birth: 2021-04-28 22:06:08.389017197 +0200

$ ~/test-localtime
2021-06-0109:22:31 +0000  # before this fix %z is wrong, it should be +0200

$ ~/test-localtime
2021-06-0111:24:30 +0200  # after this fix %z is correct

Source of test-localtime:
---------------------------------------------------------

int main(int argc, char *argv[])
{
	time_t t;
	struct tm *tm;
	char buf[256];

	t = time(NULL);
	tm = localtime(&t);
	strftime(buf, sizeof(buf), "%F%T %z", tm);

	fprintf(stdout, "%s\n", buf);

	return 0;
}
---------------------------------------------------------

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---

v1 -> v2:
 * Check for existance of /etc/localtime before touching it
 * Add comment explaingning why opening and/or reading /etc/localtime might not be enough

 lib/tst_wallclock.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/tst_wallclock.c b/lib/tst_wallclock.c
index 838dde8b3..1244ea26b 100644
--- a/lib/tst_wallclock.c
+++ b/lib/tst_wallclock.c
@@ -42,7 +42,9 @@ void tst_wallclock_save(void)
 
 void tst_wallclock_restore(void)
 {
+	static const char *localtime = "/etc/localtime";
 	static struct timespec mono_end, elapsed, adjust;
+	int ret;
 
 	if (!clock_saved)
 		return;
@@ -60,6 +62,19 @@ void tst_wallclock_restore(void)
 
 	if (tst_clock_settime(CLOCK_REALTIME, &adjust))
 		tst_brk(TBROK | TERRNO, "tst_clock_settime() realtime failed");
+
+	/*
+	 * Fix access time of /etc/localtime because adjusting the wallclock
+	 * might have changed it to a time value which lies far ahead
+	 * in the future.
+	 * The access time of a file only changes if the new one is past
+	 * the current one, therefore, just opening a file and reading it
+	 * might not be enough because the current access time might be far
+	 * in the future.
+	 */
+	ret = access(localtime, F_OK);
+	if (!ret)
+		SAFE_TOUCH(localtime, 0, NULL);
 }
 
 void tst_rtc_clock_save(const char *rtc_dev)
-- 
2.31.1

