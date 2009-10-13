Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MxWof-0001Kn-Qm
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 02:08:45 +0000
Received: from mail-pz0-f199.google.com ([209.85.222.199])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MxWoY-0004CA-TN
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 02:08:45 +0000
Received: by pzk37 with SMTP id 37so8973992pzk.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Oct 2009 19:08:33 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 12 Oct 2009 19:08:33 -0700
Message-ID: <364299f40910121908y47554fabgbda2f5411c720f92@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] Fix genhtml.pl (was "Re: HTML not reporting number of
	Failed test cases")
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
To: rohit verma <rohit.170309@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, naresh kamboju <naresh.kernel@gmail.com>

On Fri, Oct 9, 2009 at 3:00 AM, rohit verma <rohit.170309@gmail.com> wrote:
> Hi,
>
> Thanks Naresh for pointing out the issue in the HTML report. I had
> also noticed the issue in my test reports.
>
> However, I wish to confirm that the issue being mentioned is not a
> side-effect of the fix that I had posted for the pan driver.
> If you compare the HTML reports from the previous releases and the
> recent one, you can notice all the tags - FAIL, WARN, BROK, PASS,CONF
> & RETR are now prefixed by ' T ' for reasons not known to me
> (resulting in - TFAIL, TPASS etc).
>
> Now, if you check ltp-full-20090831/tools/genhtml.pl file you can see
> all that old tags (FAIL, WARN, etc) are used instead of the new
> ones(tags). As a result the numbers are not updated in the summary in
> HTML report. Also FAIL/WARN/BROK test-cases are not uniquely colored
> like in the old versions of LTP.
>
> Please check the same.
> If possible I will generate a patch and submit the same.
>
> On Wed, Oct 7, 2009 at 4:43 PM, naresh kamboju <naresh.kernel@gmail.com> wrote:
>> Hi,
>>
>> I think you have noticed difference in the HTML file generation.
>> HTML file is not reporting number of failure test cases
>> in summary and failed column with different color.
>> Some changes are made by Rohit recently.
>>
>> Rohit,
>> Please investigate the changes made to HTML file generator.
>>
>> You can refer the results logs share in LTP release in the below link for
>> X86
>> (ltp-full-20090930_results_kernel-2.6.31_architecture-i386.tgz)
>> Ia64
>> (ltp-full-20090930_results_kernel-2.6.23.13_architecture-ia64.tgz)

Try this.

Fix genhtml.pl so that it functions with the new T-prefixing in the
lib/tst_res.c result codes.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: contrib/ltp/src/tools/genhtml.pl
===================================================================
--- src/tools/.CC/cache/genhtml.pl@@/main/ltp-upgrade/1 2009-10-12
19:08:28.000000000 -0700
+++ src/tools/genhtml.pl        2009-10-12 19:08:18.000000000 -0700
@@ -179,31 +179,31 @@
                         }
                         if ( $flag2 == 1 ) {
                            $row_line = $row_line . "$line \n";
-                           if ($line =~ /\ FAIL\ / ) {
+                           if ($line =~ /\ TFAIL\ / ) {
                                $detected_fail = 1;
                                if ( $failed_test_counter_flag == 0 ) {
                                    $failed_test_counter++;
                                    $failed_test_counter_flag=1;
                                }
-                           } elsif ($line =~ /\ BROK\ / ) {
+                           } elsif ($line =~ /\ TBROK\ / ) {
                                $detected_brok = 1;
                                if ( $brok_test_counter_flag == 0 ) {
                                    $brok_test_counter++;
                                    $brok_test_counter_flag=1;
                                }
-                           } elsif ($line =~ /\ WARN\ / ) {
+                           } elsif ($line =~ /\ TWARN\ / ) {
                                $detected_warn = 1;
                                if ( $warn_test_counter_flag == 0 ) {
                                    $warn_test_counter++;
                                    $warn_test_counter_flag=1;
                                }
-                           } elsif ($line =~ /\ RETR\ / ) {
+                           } elsif ($line =~ /\ TRETR\ / ) {
                                $detected_retr = 1;
                                if ( $retr_test_counter_flag == 0 ) {
                                    $retr_test_counter++;
                                    $retr_test_counter_flag=1;
                                }
-                           } elsif ($line =~ /\ CONF\ / ) {
+                           } elsif ($line =~ /\ TCONF\ / ) {
                                $detected_conf = 1;
                                if ( $conf_test_counter_flag == 0 ) {
                                    $conf_test_counter++;
@@ -251,3 +251,5 @@
 print "<tr><td><strong>Hostname</strong>  </td> <td><strong>";
 $hostname=system("uname -n");             chop($hostname);
 print " $hostname </strong></td></tr></tbody></table></div></body></html>\n";
+
+# vim: syntax=perl

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
