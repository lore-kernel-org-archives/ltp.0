From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 7 May 2018 13:31:05 +0300
Subject: [LTP] [PATCH 1/3] lib/tst_net.sh: Append 6 to the end of
	$TST_OPTS
In-Reply-To: <20180507080900.4ebs7f3vysql7wpv@dell5510>
References: <1525663451-32016-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180507064343.ahqhsbadjpho2xry@dell5510> <5AF000B1.9070106@cn.fujitsu.com>
 <20180507080900.4ebs7f3vysql7wpv@dell5510>
Message-ID: <2f018204-f462-6c0e-2590-147f3323e51e@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05/07/2018 11:09 AM, Petr Vorel wrote:
> Hi Xiao,
> 
>>> Good catch. Although I propose to get rid of ':' at the beginning for users of new shell
>>> API (as it's IMHO better to see errors).
>> Hi Petr,
> 
>> If getopts is in silent mode,  the invalid option is  placed  in OPTARG, so
>> we can see errors by printing
>> the value of OPTARG.  But it is reasonable for me to get rid of ':' at the
>> beginning of optstring. :-)
> I know, TBROK inform us, so it can stay how it is for legacy API.
> I meant it for the new API, where is going to be removed (the TBROK as well) as error is
> handled in tst_run in tst_test.sh.
> 


What about silence error in tst_test.sh? And remove preceding column in the
tests (tcp_fastopen.sh, nfs_lib.sh). We handle the error already there, in
tst_run (and in old API the scripts have TBROK), so there is no point
printing one more redundant message that doesn't have LTP format.

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8d49d34..edac619 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -265,11 +265,12 @@ tst_run()

        OPTIND=1

-       while getopts "hi:$TST_OPTS" name $TST_ARGS; do
+       while getopts ":hi:$TST_OPTS" name $TST_ARGS; do
                case $name in
                'h') tst_usage; exit 0;;
                'i') TST_ITERATIONS=$OPTARG;;
-               '?') tst_usage; exit 2;;
+               '?') tst_usage
+                    tst_brk TBROK "invalid option: '$OPTARG'";;
                *) $TST_PARSE_ARGS "$name" "$OPTARG";;
                esac
