From: Mason <slash.tmp@free.fr>
Date: Thu, 21 Apr 2016 15:25:30 +0200
Subject: [LTP] Issue with the reporting of failed tests
Message-ID: <5718D4CA.5010607@free.fr>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

For a particular LTP run, I had 97 reported failures.

$ grep -c FAIL result-log.987
97

However, FAILCMDFILE contained 804 lines (with many duplicates).

$ wc -l result-failed.987
804 result-failed.987

$ sort result-failed.987 | uniq | wc -l
85

It seems some failures did not get recorded in FAILCMDFILE at all,
or were recorded, but later overwritten:
aio01, aio02, cgroup, controllers, ext4*, fs_racer, Numa-testcases
and some of the cron tests.


As discussed with metan on IRC, this has all the symptoms of a
FILE buffer shared between parent and child process. I am now
running LTP again with the following patch applied:

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index cee71aa3b587..44c026e88a47 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -535,6 +535,7 @@ int main(int argc, char **argv)
                                break;
                        }
 
+                       fflush(failcmdfile);
                        cpid =
                            run_child(coll->ary[c], running + i, quiet_mode,
                                      &failcnt, fmt_print, logfile);


When the run finishes, I will be able to tell if the issue
remains.

Regards.
