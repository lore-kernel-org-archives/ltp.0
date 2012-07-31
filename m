Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Sw7tV-0006dj-Hx
	for ltp-list@lists.sourceforge.net; Tue, 31 Jul 2012 08:33:33 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Sw7tP-0003oE-P0
	for ltp-list@lists.sourceforge.net; Tue, 31 Jul 2012 08:33:33 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q6V8XLVS027057
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 31 Jul 2012 04:33:21 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id q6V8XKkB012527
	for <ltp-list@lists.sourceforge.net>; Tue, 31 Jul 2012 04:33:21 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 31 Jul 2012 10:33:13 +0200
Message-Id: <c91b5e097298ae2ec6e68647ade56a32ecec6ff1.1343723571.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] proc01: add option to limit max read bytes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Add option -m to set upper limit of read megabytes from
single proc file. When this limit is reached testcase
will continue with next file.

Reason for this new option is to allow running this testcase
as sanity test, that doesn't need go through full content of
files such as "pagemap" (which can take hours).

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/fs/proc/proc01.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0001-proc01-add-option-to-limit-max-read-bytes.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-proc01-add-option-to-limit-max-read-bytes.patch"

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index 0a7695a..e3bc80b 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -58,10 +58,13 @@ static char	*opt_procpathstr;
 static int	 opt_buffsize = 0;
 static int	 opt_readirq = 0;
 static char	*opt_buffsizestr;
+static int	 opt_maxmbytes;
+static char	*opt_maxmbytesstr;
 
 static char	*procpath = "/proc";
 static char	 selfpath[] = "/proc/self";
 size_t		 buffsize = 1024;
+static long long maxbytes;
 
 unsigned long long total_read = 0;
 unsigned int total_obj = 0;
@@ -197,6 +200,7 @@ void setup()
 void help()
 {
 	printf("  -b x    read byte count\n");
+	printf("  -m x    max megabytes to read from single file\n");
 	printf("  -q      read .../irq/... entries\n");
 	printf("  -r x    proc pathname\n");
 	printf("  -v      verbose mode\n");
@@ -208,6 +212,7 @@ void help()
  */
 option_t options[] = {
 	{ "b:", &opt_buffsize,	&opt_buffsizestr},
+	{ "m:", &opt_maxmbytes,	&opt_maxmbytesstr},
 	{ "q",	&opt_readirq,	NULL },
 	{ "r:", &opt_procpath,	&opt_procpathstr},
 	{ "v",  &opt_verbose,	NULL },
@@ -243,6 +248,7 @@ long readproc(const char *obj)
 	int fd, tmperr, i;
 	ssize_t nread;
 	static char buf[MAX_BUFF_SIZE];	/* static kills reentrancy, but we don't care about the contents */
+	unsigned long long file_total_read = 0;
 
 	/* Determine the file type */
 	if (lstat(obj, &statbuf) < 0) {
@@ -373,6 +379,7 @@ long readproc(const char *obj)
 			}
 		}
 
+		file_total_read = 0;
 		do {
 
 			nread = read(fd, buf, buffsize);
@@ -400,7 +407,8 @@ long readproc(const char *obj)
 
                 		}
 
-			}
+			} else
+				file_total_read += nread;
 
 			if (opt_verbose) {
 #ifdef DEBUG
@@ -409,9 +417,13 @@ long readproc(const char *obj)
 				fprintf(stderr, ".");
 			}
 
-			total_read += nread;
-
+			if ((maxbytes > 0) && (file_total_read > maxbytes)) {
+				tst_resm(TINFO, "%s: reached maxmbytes (-m)",
+					obj);
+				break;
+			}
 		} while (0 < nread);
+		total_read += file_total_read;
 
 		if (opt_verbose)
 			fprintf(stderr, "\n");
@@ -444,6 +456,8 @@ int main(int argc, char *argv[])
 				 "Invalid arg for -b (max: %u): %s",
 				 MAX_BUFF_SIZE, opt_buffsizestr);
 	}
+	if (opt_maxmbytes)
+		maxbytes = atoi(opt_maxmbytesstr) * 1024 * 1024;
 
 	if (opt_procpath)
 		procpath = opt_procpathstr;
@@ -467,4 +481,4 @@ int main(int argc, char *argv[])
 
 	cleanup();
 	tst_exit();
-}
\ No newline at end of file
+}

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



