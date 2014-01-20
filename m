Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W5JJj-00045a-Ll
	for ltp-list@lists.sourceforge.net; Mon, 20 Jan 2014 18:11:23 +0000
Date: Mon, 20 Jan 2014 19:10:56 +0100
From: chrubis@suse.cz
Message-ID: <20140120181056.GB1280@rei.suse.cz>
References: <1386155493.1544.8.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1386155493.1544.8.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH 1/2] fpathconf/fpathconf01.c: cleanup
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
To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> cleanup of fpathconf01.c

Pushed both patches with following modifications:

 /*
- * Testcase to test the basic functionality of fpathconf(2) systemm call.
+ * Testcase to test the basic functionality of fpathconf(2) system call.
  */
                                                                ^
                                                           Fixed typo

 #include <fcntl.h>
@@ -83,13 +83,14 @@ int main(int ac, char **av)
                tst_count = 0;
 
                for (i = 0; i < TST_TOTAL; i++) {
+                       errno = 0;
                        ^
                        The fpathconf does not modify errno and returns -1 if
                        configuration option has no limit, therefore we must
                        set errno to zero ourselves.

                        TEST(fpathconf(fd, test_cases[i].value));
 
                        if (TEST_RETURN == -1) {
                                if (TEST_ERRNO == 0) {
                                        tst_resm(TINFO,
-                                                "fpathconf has NO the limit: "
+                                                "fpathconf has NO limit for "
                                                 "%s", test_cases[i].name);
                                } else {
                                        tst_resm(TFAIL | TTERRNO,
@@ -124,7 +125,8 @@ static void cleanup(void)
 {
        TEST_CLEANUP;
 
-       SAFE_CLOSE(NULL, fd);
+       if (fd > 0)
+               SAFE_CLOSE(NULL, fd);
        ^
        In unlikely case that the SAFE_OPEN() would fail you will close stdin here
        (because fd is global variable and initialized to zero).

        tst_rmdir();
 }


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
