Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1Mg616-00082Y-Ff
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 00:05:32 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mg610-0008Sg-AN
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 00:05:32 +0000
Message-ID: <4A947C25.5090809@cn.fujitsu.com>
Date: Wed, 26 Aug 2009 08:04:53 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] Add new testcases for cgroup
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>

We has created some testcases for cgroup in the last year. 
There are total 194 testcases that have been added. These testcases contain 
the basis operation test, part functionality test and stress test of cgroup.

How to run this test:
	# runltp -f controllers

Result:
Now, we start the test for cgroup...
cgroup_test_fj    1  TPASS  :  case1(function   1 1 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case2(function   1 2 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case3(function   1 1 1 2 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case4(function   1 1 1 3 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case5(function   1 1 1 4 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case6(function   1 1 1 5 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case7(function   1 1 1 6 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case8(function   1 1 1 7 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case9(function   1 1 1 8 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case10(function  2 1 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case11(function  2 2 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case12(function  2 1 2 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case13(function  2 1 1 2 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case14(function  2 1 1 3 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case15(function  2 1 1 4 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case16(function  2 1 1 5 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case17(function  2 1 1 6 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case18(function  2 1 1 7 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case19(function  2 1 1 8 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case20(function  3 1 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case21(function  3 2 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case22(function  3 1 1 2 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case23(function  3 1 1 3 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case24(function  3 1 1 4 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case25(function  3 1 1 5 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case26(function  3 1 1 6 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case27(function  3 1 1 7 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case28(function  3 1 1 8 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case29(function  4 1 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case30(function  4 2 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case31(function  4 1 1 2 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case32(function  4 1 1 3 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case33(function  4 1 1 4 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case34(function  4 1 1 5 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case35(function  4 1 1 6 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case36(function  4 1 1 7 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case37(function  4 1 1 8 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case38(function  5 1 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case39(function  5 2 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case40(function  5 1 1 2 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case41(function  5 1 1 3 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case42(function  5 1 1 4 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case43(function  5 1 1 5 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case44(function  5 1 1 6 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case45(function  5 1 1 7 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case46(function  5 1 1 8 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case47(function  6 1 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case48(function  6 2 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case49(function  6 1 1 2 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case50(function  6 1 1 3 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case51(function  6 1 1 4 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case52(function  6 1 1 5 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case53(function  6 1 1 6 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case54(function  6 1 1 7 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case55(function  6 1 1 8 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case56(function  7 1 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case57(function  7 2 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case58(function  7 1 1 2 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case59(function  7 1 1 3 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case60(function  7 1 1 4 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case61(function  7 1 1 5 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case62(function  7 1 1 6 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case63(function  7 1 1 7 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case64(function  7 1 1 8 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case65(function  8 1 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case66(function  9 1 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case67(function  9 2 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case68(function  9 1 1 2 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case69(function  9 1 1 3 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case70(function  9 1 1 4 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case71(function  9 1 1 5 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case72(function  9 1 1 6 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case73(function  9 1 1 7 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case74(function  9 1 1 8 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case75(function  10 1 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case76(function  11 1 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case77(function  11 2 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case78(function  11 1 1 2 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case79(function  11 1 1 3 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case80(function  11 1 1 4 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case81(function  11 1 1 5 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case82(function  11 1 1 6 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case83(function  11 1 1 7 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case84(function  11 1 1 8 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case85(function  12 1 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case86(function  12 2 1 1 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case87(function  12 1 1 2 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case88(function  12 1 1 3 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case89(function  12 1 1 4 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case90(function  12 1 1 5 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case91(function  12 1 1 6 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case92(function  12 1 1 7 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case93(function  12 1 1 8 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case94(function  1 1 1 1 1 1 2 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case95(function  1 1 1 1 1 2 2 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case96(function  1 1 1 1 1 2 3 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case97(function  1 1 1 1 1 2 5 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case98(function  1 1 1 1 1 3 1 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case99(function  1 1 1 1 1 3 2 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case100(function 1 1 1 1 1 3 4 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case101(function 1 1 1 1 1 4 3 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case102(function 1 1 1 1 1 4 5 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case103(function 1 1 1 1 2 1 1 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case104(function 1 1 1 1 1 1 1 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case105(function 1 1 1 1 1 1 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case106(function 1 1 1 1 1 2 3 2 2)    PASS
cgroup_test_fj    1  TPASS  :  case107(function 1 1 1 1 1 2 3 2 3)    PASS
cgroup_test_fj    1  TPASS  :  case108(function 1 1 1 1 1 2 3 2 4)    PASS
cgroup_test_fj    1  TPASS  :  case109(function 1 1 1 1 1 2 3 2 5)    PASS
cgroup_test_fj    1  TPASS  :  case110(function 1 1 1 1 1 2 3 2 6)    PASS
cgroup_test_fj    1  TPASS  :  case111(function 1 1 1 1 1 2 3 2 7)    PASS
cgroup_test_fj    1  TPASS  :  case112(function 1 1 1 1 1 2 3 3 2)    PASS
cgroup_test_fj    1  TPASS  :  case113(function 1 1 1 1 1 2 3 4 2)    PASS
cgroup_test_fj    1  TPASS  :  case114(function 1 1 1 1 1 2 3 5 2)    PASS
cgroup_test_fj    1  TPASS  :  case115(function 1 1 1 1 1 2 3 6 2)    PASS
cgroup_test_fj    1  TPASS  :  case116(function 1 1 1 1 1 2 3 7 2)    PASS
cgroup_test_fj    1  TPASS  :  case117(function 1 1 1 2 1 2 3 2 2)    PASS
cgroup_test_fj    1  TPASS  :  case118(function 1 1 1 3 1 2 3 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case119(function 1 1 1 3 1 2 3 1 2)    PASS
cgroup_test_fj    1  TPASS  :  case120(function 1 1 1 3 1 2 3 1 3)    PASS
cgroup_test_fj    1  TPASS  :  case121(function 1 1 1 3 1 2 3 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case122(function 1 1 1 3 1 2 3 2 2)    PASS
cgroup_test_fj    1  TPASS  :  case123(function 1 1 1 3 1 2 3 2 3)    PASS
cgroup_test_fj    1  TPASS  :  case124(function 1 1 1 3 1 2 3 2 4)    PASS
cgroup_test_fj    1  TPASS  :  case125(function 1 1 1 3 1 2 3 2 5)    PASS
cgroup_test_fj    1  TPASS  :  case126(function 1 1 1 3 1 2 3 2 6)    PASS
cgroup_test_fj    1  TPASS  :  case127(function 1 1 1 3 1 2 3 2 7)    PASS
cgroup_test_fj    1  TPASS  :  case128(function 1 1 1 3 1 2 3 3 1)    PASS
cgroup_test_fj    1  TPASS  :  case129(function 1 1 1 3 1 2 3 3 2)    PASS
cgroup_test_fj    1  TPASS  :  case130(function 1 1 1 3 1 2 3 3 3)    PASS
cgroup_test_fj    1  TPASS  :  case131(function 1 1 1 3 1 2 3 4 2)    PASS
cgroup_test_fj    1  TPASS  :  case132(function 1 1 1 3 1 2 3 5 2)    PASS
cgroup_test_fj    1  TPASS  :  case133(function 1 1 1 3 1 2 3 6 2)    PASS
cgroup_test_fj    1  TPASS  :  case134(function 1 1 1 3 1 2 3 7 2)    PASS
cgroup_test_fj    1  TPASS  :  case135(function2        1)    PASS
cgroup_test_fj    1  TPASS  :  case136(function2        2)    PASS
cgroup_test_fj    1  TPASS  :  case137(function2        3)    PASS
cgroup_test_fj    1  TPASS  :  case138(function2        4)    PASS
cgroup_test_fj    1  TPASS  :  case139(function2        5)    PASS
cgroup_test_fj    1  TPASS  :  case140(function2        6)    PASS
cgroup_test_fj    1  TPASS  :  case141(function2        7)    PASS
cgroup_test_fj    1  TPASS  :  case142(function2        8)    PASS
cgroup_test_fj    1  TPASS  :  case143(function2        9)    PASS
cgroup_test_fj    1  TPASS  :  case144(function2        10)    PASS
cgroup_test_fj    1  TPASS  :  case145(function2        11)    PASS
cgroup_test_fj    1  TPASS  :  case146(function2        12)    PASS
cgroup_test_fj    1  TPASS  :  case147(function2        13)    PASS
cgroup_test_fj    1  TPASS  :  case148(stress   1 2 1 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case149(stress   2 2 1 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case150(stress   3 2 1 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case151(stress   4 2 1 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case152(stress   5 2 1 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case153(stress   6 2 1 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case154(stress   7 2 1 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case155(stress   1 1 1 1 2)    PASS
cgroup_test_fj    1  TPASS  :  case156(stress   1 1 1 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case157(stress   1 1 1 2 2)    PASS
cgroup_test_fj    1  TPASS  :  case158(stress   1 1 1 2 3)    PASS
cgroup_test_fj    1  TPASS  :  case159(stress   1 1 2 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case160(stress   1 1 2 1 2)    PASS
cgroup_test_fj    1  TPASS  :  case161(stress   1 1 2 1 3)    PASS
cgroup_test_fj    1  TPASS  :  case162(stress   1 1 2 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case163(stress   1 1 2 2 2)    PASS
cgroup_test_fj    1  TPASS  :  case164(stress   2 1 1 1 2)    PASS
cgroup_test_fj    1  TPASS  :  case165(stress   2 1 1 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case166(stress   2 1 1 2 2)    PASS
cgroup_test_fj    1  TPASS  :  case167(stress   2 1 1 2 3)    PASS
cgroup_test_fj    1  TPASS  :  case168(stress   2 1 2 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case169(stress   2 1 2 1 2)    PASS
cgroup_test_fj    1  TPASS  :  case170(stress   2 1 2 1 3)    PASS
cgroup_test_fj    1  TPASS  :  case171(stress   2 1 2 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case172(stress   2 1 2 2 2)    PASS
cgroup_test_fj    1  TPASS  :  case173(stress   4 1 1 1 2)    PASS
cgroup_test_fj    1  TPASS  :  case174(stress   4 1 2 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case175(stress   4 1 2 1 2)    PASS
cgroup_test_fj    1  TPASS  :  case176(stress   4 1 2 1 3)    PASS
cgroup_test_fj    1  TPASS  :  case177(stress   5 1 1 1 2)    PASS
cgroup_test_fj    1  TPASS  :  case178(stress   5 1 1 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case179(stress   5 1 1 2 2)    PASS
cgroup_test_fj    1  TPASS  :  case180(stress   5 1 1 2 3)    PASS
cgroup_test_fj    1  TPASS  :  case181(stress   5 1 2 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case182(stress   5 1 2 1 2)    PASS
cgroup_test_fj    1  TPASS  :  case183(stress   5 1 2 1 3)    PASS
cgroup_test_fj    1  TPASS  :  case184(stress   5 1 2 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case185(stress   5 1 2 2 2)    PASS
cgroup_test_fj    1  TPASS  :  case186(stress   6 1 1 1 2)    PASS
cgroup_test_fj    1  TPASS  :  case187(stress   6 1 1 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case188(stress   6 1 1 2 2)    PASS
cgroup_test_fj    1  TPASS  :  case189(stress   6 1 1 2 3)    PASS
cgroup_test_fj    1  TPASS  :  case190(stress   6 1 2 1 1)    PASS
cgroup_test_fj    1  TPASS  :  case191(stress   6 1 2 1 2)    PASS
cgroup_test_fj    1  TPASS  :  case192(stress   6 1 2 1 3)    PASS
cgroup_test_fj    1  TPASS  :  case193(stress   6 1 2 2 1)    PASS
cgroup_test_fj    1  TPASS  :  case194(stress   6 1 2 2 2)    PASS


Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
---
 runtest/controllers                                            |    1
 testcases/kernel/controllers/Makefile                          |    2
 testcases/kernel/controllers/cgroup_fj/Makefile                |   19
 testcases/kernel/controllers/cgroup_fj/README                  |   56
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh   |  269 ++++
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh  |  329 +++++
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_proc.c        |   77 +
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_release_agent |   11
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh     |  340 +++++
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_testcases     |  194 +++
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh    |  633 ++++++++++
 testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh   |  135 ++
 12 files changed, 2066 insertions(+)

diff -urpN ltp-full-20090731.orig/runtest/controllers ltp-full-20090731.cg/runtest/controllers
--- ltp-full-20090731.orig/runtest/controllers	2009-05-18 07:50:16.000000000 -0400
+++ ltp-full-20090731.cg/runtest/controllers	2009-08-24 15:15:05.000000000 -0400
@@ -1,4 +1,5 @@
 #DESCRIPTION:Resource Management testing
 cgroup		cgroup_regression_test.sh
 memcg		memcg_regression_test.sh
+cgroup_fj	run_cgroup_test_fj.sh
 controllers	test_controllers.sh
diff -urpN ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh
--- ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh	1969-12-31 19:00:00.000000000 -0500
+++ ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function2.sh	2009-08-23 10:18:51.000000000 -0400
@@ -0,0 +1,329 @@
+#! /bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2009 FUJITSU LIMITED                                         ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+## Author: Shi Weihua <shiwh@cn.fujitsu.com>                                  ##
+##                                                                            ##
+################################################################################
+
+caseno=$1
+pid=0;
+subsystem=1;
+release_agent_para=1;
+release_agent_echo=1;
+subsystem_str="debug";
+remount_use_str="";
+noprefix_use_str="";
+release_agent_para_str="";
+
+# not output debug info when stress test
+no_debug=0
+
+usage()
+{
+	echo "usage of cgroup_fj_function2.sh: "
+	echo "  ./cgroup_fj_function2.sh -case number[1-13]"
+	echo "example: ./cgroup_fj_function2.sh 1"
+	echo "  will test the 1st case"
+}
+
+exit_parameter()
+{
+	echo "ERROR: Wrong inputed parameter..Exiting test" >> $LOGFILE
+	exit -1;
+}
+
+export TESTROOT=`pwd`
+if [ "$LOGFILE" = "" ]; then
+	LOGFILE="/dev/stdout"
+fi
+export TMPFILE=$TESTROOT/tmp_tasks
+
+. $TESTROOT/cgroup_fj_utility.sh
+
+case1()
+{
+	do_mkdir 1 1 /dev/cgroup/subgroup_2
+	
+	do_echo 1 0 $pid /dev/cgroup/subgroup_1/tasks
+	sleep 1
+	do_echo 1 0 $pid /dev/cgroup/subgroup_2/tasks
+	sleep 1
+	do_echo 1 1 $pid /dev/cgroup/tasks
+}
+
+case2()
+{
+	do_mkdir 1 1 /dev/cgroup/subgroup_2
+	
+	$TESTROOT/cgroup_fj_proc &
+	pid2=$!
+	sleep 1
+	
+	cat /dev/cgroup/tasks > $TMPFILE
+	nlines=`cat $TMPFILE | wc -l`
+	for i in `seq 1 $nlines`
+	do
+		cur_pid=`sed -n "$i""p" $TMPFILE`
+		if [ -e /proc/$cur_pid/ ];then
+			do_echo 1 0 "$cur_pid" /dev/cgroup/subgroup_1/tasks
+		fi
+	done
+	
+	sleep 1
+	
+	cat /dev/cgroup/subgroup_1/tasks > $TMPFILE
+	nlines=`cat $TMPFILE | wc -l`
+	for i in `seq 1 $nlines`
+	do
+		cur_pid=`sed -n "$i""p" $TMPFILE`
+		if [ -e /proc/$cur_pid/ ];then
+			do_echo 1 0 "$cur_pid" /dev/cgroup/subgroup_2/tasks
+		fi
+	done
+	
+	sleep 1
+	
+	cat /dev/cgroup/subgroup_2/tasks > $TMPFILE
+	nlines=`cat $TMPFILE | wc -l`
+	for i in `seq 1 $nlines`
+	do
+		cur_pid=`sed -n "$i""p" $TMPFILE`
+		if [ -e /proc/$cur_pid/ ];then
+			do_echo 1 1 "$cur_pid" /dev/cgroup/tasks
+		fi
+	done
+}
+
+case3()
+{
+	exist_subsystem "cpuset"
+	exist_subsystem "ns"
+	do_mount 1 1 "-odebug,cpuset,ns" /dev/cgroup cgroup1
+	
+	mount_str="`mount -l | grep /dev/cgroup2`"
+	if [ "$mount_str" != "" ]; then
+		do_umount 0 1 /dev/cgroup2
+	fi
+	
+	if [ -e /dev/cgroup2 ]; then
+		do_rmdir 1 1 /dev/cgroup2
+	fi
+	
+	do_mkdir 1 1 /dev/cgroup2
+
+	exist_subsystem "cpu"
+	exist_subsystem "cpuacct"
+	exist_subsystem "memory"
+	do_mount 1 1 "-ocpu,cpuacct,memory" /dev/cgroup2 cgroup2
+	
+	sleep 1
+	
+	do_umount 0 1 /dev/cgroup
+	do_rmdir 0 1 /dev/cgroup
+	do_umount 0 1 /dev/cgroup2
+	do_rmdir 0 1 /dev/cgroup2
+}
+
+case4()
+{
+	exist_subsystem "cpuset"
+	exist_subsystem "ns"
+	do_mount 1 1 "-odebug,cpuset,ns" /dev/cgroup cgroup1
+	
+	mount_str="`mount -l | grep /dev/cgroup2`"
+	if [ "$mount_str" != "" ]; then
+		do_umount 1 1 /dev/cgroup2
+	fi
+	
+	if [ -e /dev/cgroup2 ]; then
+		do_rmdir 0 1 /dev/cgroup2
+	fi
+	
+	do_mkdir 0 1 /dev/cgroup2
+	
+	do_mount 1 1 "-odebug,cpuset,ns" /dev/cgroup2 cgroup2
+	
+	sleep 1
+	
+	do_umount 0 1 /dev/cgroup
+	do_rmdir 0 1 /dev/cgroup
+	do_umount 0 1 /dev/cgroup2
+	do_rmdir 0 1 /dev/cgroup2
+}
+
+case5()
+{
+	exist_subsystem "cpuset"
+	exist_subsystem "ns"
+	exist_subsystem "memory"
+	do_mount 1 1 "-odebug,cpuset,ns" /dev/cgroup cgroup1
+	
+	mount_str="`mount -l | grep /dev/cgroup2`"
+	if [ "$mount_str" != "" ]; then
+		do_umount 1 1 /dev/cgroup2
+	fi
+	
+	if [ -e /dev/cgroup2 ]; then
+		do_rmdir 0 1 /dev/cgroup2
+	fi
+	
+	do_mkdir 0 1 /dev/cgroup2
+	
+	do_mount 0 1 "-odebug,cpuset,memory" /dev/cgroup2 cgroup2
+	
+	sleep 1
+	
+	do_umount 0 1 /dev/cgroup
+	do_rmdir 0 1 /dev/cgroup
+	do_umount 0 1 /dev/cgroup2
+	do_rmdir 0 1 /dev/cgroup2
+}
+
+case6()
+{
+	exist_subsystem "debug"
+	exist_subsystem "cpuset"
+	exist_subsystem "ns"
+	do_mount 1 1 "-odebug,cpuset,ns" /dev/cgroup cgroup1
+	
+	mount_str="`mount -l | grep /dev/cgroup2`"
+	if [ "$mount_str" != "" ]; then
+		do_umount 1 1 /dev/cgroup2
+	fi
+	
+	if [ -e /dev/cgroup2 ]; then
+		do_rmdir 0 1 /dev/cgroup2
+	fi
+	
+	do_mkdir 0 1 /dev/cgroup2
+	
+	do_mount 0 1 "-oall" /dev/cgroup2 cgroup2
+	
+	sleep 1
+	
+	do_umount 0 1 /dev/cgroup
+	do_rmdir 0 1 /dev/cgroup
+	do_umount 0 1 /dev/cgroup2
+	do_rmdir 0 1 /dev/cgroup2
+}
+
+case7()
+{
+	do_mkdir 0 1 /dev/cgroup/subgroup_2
+	
+	do_mv 0 1 /dev/cgroup/subgroup_1 /dev/cgroup/subgroup_3
+}
+
+case8()
+{
+	do_mkdir 0 1 /dev/cgroup/subgroup_2
+	
+	do_mv 0 0 /dev/cgroup/subgroup_1 /dev/cgroup/subgroup_2
+}
+
+case9()
+{
+	mount_str="`mount -l | grep /dev/cgroup2`"
+	if [ "$mount_str" != "" ]; then
+		do_umount 1 1 /dev/cgroup2
+	fi
+	
+	if [ -e /dev/cgroup2 ]; then
+		do_rmdir 0 1 /dev/cgroup2
+	fi
+	
+	do_mkdir 0 1 /dev/cgroup2
+	
+	do_mkdir 0 1 /dev/cgroup2/subgroup_2
+	
+	do_mv 0 1 /dev/cgroup/subgroup_1 /dev/cgroup/subgroup_2
+
+	sleep 1
+
+	do_rmdir 0 1 /dev/cgroup2/subgroup_2
+	do_rmdir 0 1 /dev/cgroup2
+}
+
+case10()
+{
+	do_mkdir 0 1 /dev/cgroup/subgroup_2
+	
+	do_mv 0 0 /dev/cgroup/subgroup_1 /dev/cgroup/tasks
+}
+
+case11()
+{
+	do_echo 0 1 $pid /dev/cgroup/subgroup_1/tasks
+	
+	sleep 1
+	
+	do_rmdir 0 0 /dev/cgroup/subgroup_1
+	
+	sleep 1
+	
+	do_echo 1 1 $pid /dev/cgroup/tasks
+}
+
+case12()
+{
+	do_mkdir 0 1 /dev/cgroup/subgroup_1/subgroup_1_1
+	
+	sleep 1
+	
+	do_rmdir 0 0 /dev/cgroup/subgroup_1
+	
+	do_rmdir 1 1 /dev/cgroup/subgroup_1/subgroup_1_1
+}
+
+case13()
+{
+	do_rmdir 0 1 /dev/cgroup/subgroup_1
+}
+
+##########################  main   #######################
+if [ "$#" -ne "1" ] || [ $caseno -lt 1 ] || [ $caseno -gt 13 ]; then
+	usage;
+	exit_parameter;
+fi
+
+echo "-------------------------------------------------------------------------" >> $LOGFILE
+echo "case no : $CASENO1" >> $LOGFILE
+echo `date` >> $LOGFILE
+
+exist_subsystem "debug"	
+setup;
+
+echo "INFO: now we begin to test no $CASENO1 ..." >> $LOGFILE
+
+if [ $caseno -lt 3 ] || [ $caseno -gt 6 ]; then
+	mount_cgroup;
+	$TESTROOT/cgroup_fj_proc &
+	pid=$!
+	mkdir_subgroup;
+fi
+
+case$caseno
+
+cleanup;
+if [ $caseno -lt 3 ] || [ $caseno -gt 6 ]; then
+	do_kill 1 1 9 $pid
+fi
+sleep 1	
+exit 0;
diff -urpN ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
--- ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh	1969-12-31 19:00:00.000000000 -0500
+++ ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh	2009-08-23 10:15:08.000000000 -0400
@@ -0,0 +1,269 @@
+#! /bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2009 FUJITSU LIMITED                                         ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+## Author: Shi Weihua <shiwh@cn.fujitsu.com>                                  ##
+##                                                                            ##
+################################################################################
+
+subsystem=$1
+remount_use=$2
+noprefix_use=$3	
+release_agent_para=$4
+subgroup_exist=$5
+attach_operation=$6
+remove_operation=$7
+notify_on_release=$8
+release_agent_echo=$9
+
+subsystem_str="";
+remount_use_str="";
+noprefix_use_str="";
+release_agent_para_str="";
+notify_on_release_str="";
+release_agent_str="";
+
+expectted=1;
+
+# Create some processes and move them to cgroups
+pid=0;
+pid2=0;
+
+# not output debug info
+no_debug=0
+
+usage()
+{
+	echo "usage of cgroup_fj_function.sh: "
+	echo "  ./cgroup_fj_function.sh -subsystem -remount_use -noprefix_use -release_agent_para"
+	echo "                          -subgroup_exist -attach_operation -remove_operation"
+	echo "                          -notify_on_release -release_agent_echo"
+	echo "    subsystem's usable number"
+	echo "      1: debug"
+	echo "      2: cpuset"
+	echo "      3: ns"
+	echo "      4: cpu"
+	echo "      5: cpuacct"
+	echo "      6: memory"
+	echo "      7: all"
+	echo "      8: (none)"
+	echo "      9: debug,debug"
+	echo "      10: (nonexistent subsystem), e.g. abc"
+	echo "      11: freezer"
+	echo "      11: devices"
+	echo "    remount_use's usable number"
+	echo "      1: do not use remount in "-o"'s parameter"
+	echo "      2: use it"
+	echo "    noprefix_use's usable number"
+	echo "      1: do not use noprefix in "-o"'s parameter"
+	echo "      2: use it. only cpuset available"
+	echo "    release_agent_para's usable number"
+	echo "      1: don't use release_agent_para= in "-o"'s parameter"
+	echo "      2: empty after "=""
+	echo "      3: available commad"
+	echo "      4: command name exclude full path"
+	echo "      5: command in /sbin"
+	echo "      6: command in other directory"
+	echo "      7: nonexistent command"
+	echo "      8: no-permission command"
+	echo "    subgroup_exist's usable number"
+	echo "      1: subgroup will been created"
+	echo "      2: subgroup will not been created"
+	echo "    attach_operation's usable number"
+	echo "      1: attach nothing"
+	echo "      2: attach one process by echo"
+	echo "      3: attach all processes in root group by echo"
+	echo "      4: attach child forked processes automatically"
+	echo "      5: move one process to other subgroup by echo"
+	echo "      6: move all processes to other subgroup by echo"
+	echo "    remove_operation's usable number"
+	echo "      1: remove nothing"
+	echo "      2: remove some processes by echo"
+	echo "      3: remove all processes in sub group by echo"
+	echo "      4: remove some processes by kill"
+	echo "      5: remove all forked processes by kill"
+	echo "    notify_on_release's usable number"
+	echo "      1: echo 0 to notify_on_release"
+	echo "      2: echo 1 to notify_on_release"
+	echo "      3: echo 2 to notify_on_release"
+	echo "      4: echo -1 to notify_on_release"
+	echo "      5: echo 0ddd to notify_on_release"
+	echo "      6: echo 1ddd to notify_on_release"
+	echo "      7: echo ddd1 to notify_on_release"
+	echo "    release_agent_echo's usable number"
+	echo "      1: echo nothing to release_agent"
+	echo "      2: available commad"
+	echo "      3: command name exclude full path"
+	echo "      4: command in /sbin"
+	echo "      5: command in other directory"
+	echo "      6: nonexistent command"
+	echo "      7: no-permission command"
+	echo "example: ./cgroup_fj_function.sh 1 1 1 1 1 1 1 1 1"
+	echo "  will use "debug" to test, will not use option "remount","noprefix","release_agent""
+	echo "  in in "-o"'s parameter, will create some subgroup, will not attach/remove any process"
+	echo "  will echo 0 to notify_on_release and will not echo anything to release_agent"
+}
+
+export TESTROOT=`pwd`
+if [ "$LOGFILE" = "" ]; then
+	LOGFILE="/dev/stdout"
+fi
+export TMPFILE=$TESTROOT/tmp_tasks
+
+. $TESTROOT/cgroup_fj_utility.sh
+
+##########################  main   #######################
+if [ "$#" -ne "9" ]; then
+	echo "ERROR: Wrong inputed parameter..Exiting test" >> $LOGFILE;
+	usage;
+	exit -1;
+fi
+
+echo "-------------------------------------------------------------------------" >> $LOGFILE
+echo "case no : $CASENO1" >> $LOGFILE
+echo `date` >> $LOGFILE
+
+check_para;
+if [ $? -ne 0 ]; then
+	usage;
+	exit -1;
+fi
+setup;
+
+echo "INFO: now we begin to test no $CASENO1 ..." >> $LOGFILE
+
+mount_cgroup;
+
+$TESTROOT/cgroup_fj_proc &
+pid=$!
+
+mkdir_subgroup;
+
+# cpuset.cpus and cpuset.mems should be specified with suitable value 
+# before attaching operation if subsystem is cpuset
+if [ $subsystem -eq 2 ] || [ $subsystem -eq 7 ] || [ $subsystem -eq 8 ] ; then
+	exist=`grep -w cpuset /proc/cgroups | cut -f1`;
+	if [ "$exist" != "" ]; then
+		if [ $noprefix_use -eq 2 ]; then
+			do_echo 1 1 `cat /dev/cgroup/cpus` /dev/cgroup/subgroup_1/cpus;
+			do_echo 1 1 `cat /dev/cgroup/mems` /dev/cgroup/subgroup_1/mems;
+		else
+			do_echo 1 1 `cat /dev/cgroup/cpuset.cpus` /dev/cgroup/subgroup_1/cpuset.cpus;
+			do_echo 1 1 `cat /dev/cgroup/cpuset.mems` /dev/cgroup/subgroup_1/cpuset.mems;
+		fi
+	fi
+fi
+
+# attaching operation
+case $attach_operation in
+"1" )
+	;;
+"2" )
+	do_echo 1 1 $pid /dev/cgroup/subgroup_1/tasks;
+	;;
+"3" )
+	$TESTROOT/cgroup_fj_proc &
+	pid2=$!
+	cat /dev/cgroup/tasks > $TMPFILE
+	nlines=`cat $TMPFILE | wc -l`
+	for i in `seq 1 $nlines`
+	do
+		cur_pid=`sed -n "$i""p" $TMPFILE`
+		if [ -e /proc/$cur_pid/ ];then
+			do_echo 1 1 "$cur_pid" /dev/cgroup/subgroup_1/tasks
+		fi
+	done
+	;;
+"4" )
+	do_echo 1 1 $pid /dev/cgroup/subgroup_1/tasks;
+	sleep 1
+	do_kill 1 1 10 $pid
+	;;
+esac
+
+# echo notify_on_release that analysed from parameter
+case $notify_on_release in
+"1"|"2"|"3")
+	expectted=1
+	;;
+*)
+	expectted=0
+	;;
+esac
+
+#if [ $notify_on_release -ne 0 ] && [ $notify_on_release -ne 1 ] && [ $notify_on_release -ne 2 ];then
+#	expectted=0
+#fi
+do_echo 1 $expectted $notify_on_release_str /dev/cgroup/subgroup_1/notify_on_release;
+
+# echo release_agent that analysed from parameter
+if [ $release_agent_echo -ne 1 ]; then
+	do_echo 1 1 $release_agent_str /dev/cgroup/release_agent;
+fi
+
+sleep 1
+
+# pid could not be echoed from subgroup if subsystem is ( or include ) ns, 
+# so we kill them here
+if [ $subsystem -eq 3 ] || [ $subsystem -eq 7 ] || [ $subsystem -eq 8 ] ; then
+	do_kill 1 1 9 $pid
+	do_kill 1 1 9 $pid2
+# removing operation
+else
+	case $remove_operation in
+	"1" )
+		;;
+	"2" )
+		do_echo 1 1 $pid /dev/cgroup/tasks
+		if [ $pid2 -ne 0 ]  ; then
+			do_echo 1 1 $pid2 /dev/cgroup/tasks
+		fi
+		;;
+	"3" )
+		cat /dev/cgroup/subgroup_1/tasks > $TMPFILE
+		nlines=`cat $TMPFILE | wc -l`
+		if [ $nlines -ne 0 ]; then
+			for i in `seq 1 $nlines`
+			do
+				cur_pid=`sed -n "$i""p" $TMPFILE`
+				if [ -e /proc/$cur_pid/ ];then
+					do_echo 1 1 "$cur_pid" /dev/cgroup/tasks
+				fi
+			done
+		fi
+		;;
+	"4" )
+		do_kill 1 1 9 $pid
+		;;
+	"5" )
+		do_kill 1 1 9 $pid
+		do_kill 1 1 9 $pid2
+		;;
+	esac
+fi
+
+sleep 1
+
+do_rmdir 0 1 /dev/cgroup/subgroup_*
+
+cleanup;
+do_kill 1 1 9 $pid
+do_kill 1 1 9 $pid2
+sleep 1	
+exit 0;
diff -urpN ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/cgroup_fj_proc.c ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/cgroup_fj_proc.c
--- ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/cgroup_fj_proc.c	1969-12-31 19:00:00.000000000 -0500
+++ ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/cgroup_fj_proc.c	2009-08-23 10:08:01.000000000 -0400
@@ -0,0 +1,77 @@
+/******************************************************************************/
+/*                                                                            */
+/* Copyright (c) 2009 FUJITSU LIMITED                                         */
+/*                                                                            */
+/* This program is free software;  you can redistribute it and/or modify      */
+/* it under the terms of the GNU General Public License as published by       */
+/* the Free Software Foundation; either version 2 of the License, or          */
+/* (at your option) any later version.                                        */
+/*                                                                            */
+/* This program is distributed in the hope that it will be useful,            */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
+/* the GNU General Public License for more details.                           */
+/*                                                                            */
+/* You should have received a copy of the GNU General Public License          */
+/* along with this program;  if not, write to the Free Software               */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
+/*                                                                            */
+/* Author: Shi Weihua <shiwh@cn.fujitsu.com>                                  */
+/*                                                                            */
+/******************************************************************************/
+ 
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <errno.h>
+#include <err.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#define UNUSED __attribute__ ((unused))
+
+static int test_switch = 0;
+
+void sighandler(UNUSED int signo)
+{
+	test_switch = !test_switch;
+}
+
+int main(void)
+{
+	sigset_t sigset;
+	struct sigaction sa;
+	pid_t pid;
+	int status;
+	int count = 0;
+
+	sa.sa_handler = sighandler;
+	if (sigemptyset(&sa.sa_mask) < 0)
+		err(1, "sigemptyset()");
+
+	sa.sa_flags = 0;
+	if (sigaction(SIGUSR1, &sa, NULL) < 0)
+		err(1, "sigaction()");
+
+	if (sigemptyset(&sigset) < 0)
+		err(1, "sigemptyset()");
+
+	/* wait for the signal SIGUSR1 to start testing */
+	sigsuspend(&sigset);
+	if (errno != EINTR)
+		err(1, "sigsuspend()");
+
+	do {
+		count++;
+		pid = fork();
+		if (pid == -1)
+			err(1, "fork()");
+		else if (pid == 0){
+			return 0;
+		} else {
+			wait(&status);
+		}
+	} while (test_switch);
+	return 0;
+}
diff -urpN ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/cgroup_fj_release_agent ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/cgroup_fj_release_agent
--- ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/cgroup_fj_release_agent	1969-12-31 19:00:00.000000000 -0500
+++ ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/cgroup_fj_release_agent	2009-08-24 15:18:45.000000000 -0400
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+TESTROOT=`pwd`
+
+if [ -e /dev/cgroup/subgroup_1 ]
+then
+	cd /dev/cgroup
+	rmdir -p subgroup_*/ 2>/dev/null
+	rmdir /dev/cgroup/subgroup_* 2> /dev/null
+	cd $TESTROOT
+fi
diff -urpN ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
--- ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh	1969-12-31 19:00:00.000000000 -0500
+++ ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh	2009-08-23 10:29:49.000000000 -0400
@@ -0,0 +1,340 @@
+#! /bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2009 FUJITSU LIMITED                                         ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+## Author: Shi Weihua <shiwh@cn.fujitsu.com>                                  ##
+##                                                                            ##
+################################################################################
+
+subsystem=$1			# 1: debug
+				# 2: cpuset
+				# 3: ns
+				# 4: cpu
+				# 5: cpuacct
+				# 6: memory
+				# 7: all
+mount_times=$2			#1: execute once
+				#2: execute 100 times
+subgroup_num=$3			#subgroup number in the same hierarchy
+				#1: 1
+				#2: 100
+subgroup_hiers=$4		#number of subgroup's hierarchy
+				#1: 1
+				#2: 100
+attach_operation=$5		# 1: attach one process to every subcgroup
+				# 2: attach all processes in root group to one subcgroup
+				# 3: attach all processes in root group to every subcgroup
+
+usage()
+{
+	echo "usage of cgroup_fj_stress.sh: "
+	echo "  ./cgroup_fj_stress.sh -subsystem -mount_times -subgroup_num -subgroup_hiers -attach_operation"
+	echo "    subsystem's usable number"
+	echo "      1: debug"
+	echo "      2: cpuset"
+	echo "      3: ns"
+	echo "      4: cpu"
+	echo "      5: cpuacct"
+	echo "      6: memory"
+	echo "      7: all"
+	echo "    mount_times's usable number"
+	echo "      1: execute once"
+	echo "      2: execute 100 times"
+	echo "    subgroup_num's usable number"
+	echo "      (subgroup number in the same hierarchy)"
+	echo "      1: 1"
+	echo "      2: 100"
+        echo "    subgroup_hiers's usable number"
+	echo "      (number of subgroup's hierarchy)"
+	echo "      1: 1"
+	echo "      2: 100"
+	echo "    attach_operation's usable number"
+	echo "      1: attach one process to every subcgroup"
+	echo "      2: attach all processes in root group to one subcgroup"
+	echo "      3: attach all processes in root group to every subcgroup"
+        echo "example: ./cgroup_fj_stress.sh 1 1 1 1 1"
+        echo "  will use "debug" to test, will mount once, will create one subgroup in same hierarchy,"
+	echo "  will create one hierarchy, will attach one process to every subcgroup"
+}
+
+
+exit_parameter()
+{
+	echo "ERROR: Wrong inputed parameter..Exiting test" >> $LOGFILE
+	exit -1;
+}
+
+export TESTROOT=`pwd`
+if [ "$LOGFILE" = "" ]; then
+	LOGFILE="/dev/stdout"
+fi
+export TMPFILE=$TESTROOT/tmp_tasks
+
+. $TESTROOT/cgroup_fj_utility.sh
+
+pid=0;
+release_agent_para=1;
+release_agent_echo=1;
+subsystem_str="debug";
+get_subsystem;
+if [ "$?" -ne "0" ] || [ "$#" -ne "5" ]; then
+	usage;
+	exit_parameter;
+fi
+remount_use_str="";
+noprefix_use_str="";
+release_agent_para_str="";
+ulimit_u=`ulimit -u`
+no_debug=1
+cur_subgroup_path1=""
+cur_subgroup_path2=""
+
+get_subgroup_path1()
+{
+	cur_subgroup_path1=""
+	if [ "$#" -ne 1 ] || [ "$1" -lt 1 ] || [ "$1" -gt $ulimit_u ]; then
+		return;
+	fi
+	
+	cur_subgroup_path1="/dev/cgroup/subgroup_$1/"
+}
+
+
+get_subgroup_path2()
+{
+	cur_subgroup_path2=""
+	if [ "$#" -ne 1 ] || [ "$1" -lt 2 ] || [ "$1" -gt $ulimit_u ]; then
+		return;
+	fi
+	
+	for i in `seq 2 $1`
+	do
+		cur_subgroup_path2="$cur_subgroup_path2""s/"
+	done
+}
+
+case $mount_times in
+"1" )
+	mount_times=1
+	;;
+"2" )
+	mount_times=100
+	;;
+*  )
+	usage;
+	exit_parameter;
+	;;
+esac
+
+case $subgroup_num in
+"1" )
+	subgroup_num=1
+	;;
+"2" )
+	subgroup_num=100
+	;;
+*  )
+	usage;
+	exit_parameter;
+	;;
+esac
+
+case $subgroup_hiers in
+"1" )
+	subgroup_hiers=1
+	;;
+"2" )
+	subgroup_hiers=100
+	;;
+*  )
+	usage;
+	exit_parameter;
+	;;
+esac
+
+##########################  main   #######################
+echo "-------------------------------------------------------------------------" >> $LOGFILE
+echo "case no : $CASENO2" >> $LOGFILE
+echo `date` >> $LOGFILE
+
+setup;
+
+echo "INFO: now we begin to stress test no $CASENO2 ..." >> $LOGFILE
+
+mount_cgroup;
+
+$TESTROOT/cgroup_fj_proc &
+pid=$!
+
+cpus=0
+mems=0
+exist_cpuset=0
+exist_cpuset=`grep -w cpuset /proc/cgroups | cut -f1`;
+if [ $subsystem -eq 2 ] || [ $subsystem -eq 7 ] ; then
+	if [ "$exist_cpuset" != "" ]; then
+		cpus=`cat /dev/cgroup/cpuset.cpus`
+		mems=`cat /dev/cgroup/cpuset.mems`
+	fi
+fi
+
+mkdir_subgroup;
+
+# cpuset.cpus and cpuset.mems should be specified with suitable value 
+# before attachint operation if subsystem is cpuset
+if [ $subsystem -eq 2 ] || [ $subsystem -eq 7 ] ; then
+	if [ "$exist_cpuset" != "" ]; then
+		do_echo 1 1 "$cpus" /dev/cgroup/subgroup_1/cpuset.cpus;
+		do_echo 1 1 "$mems" /dev/cgroup/subgroup_1/cpuset.mems;
+	fi
+fi
+
+if [ $mount_times -ne 1 ]; then
+	count=0
+	for i in `seq 1 $mount_times`
+	do
+		do_echo 1 1 $pid /dev/cgroup/subgroup_1/tasks
+		if [ $subsystem -eq 3 ] || [ $subsystem -eq 7 ] ; then
+			do_kill 1 1 9 $pid
+			$TESTROOT/cgroup_fj_proc &
+			pid=$!
+		else
+			do_echo 1 1 $pid /dev/cgroup/tasks
+		fi
+		setup;
+		$TESTROOT/cgroup_fj_proc &
+		pid=$!
+		mount_cgroup;
+		mkdir_subgroup;
+		if [ $subsystem -eq 2 ] || [ $subsystem -eq 7 ] ; then
+			if [ "$exist_cpuset" != "" ]; then
+				do_echo 1 1 "$cpus" /dev/cgroup/subgroup_1/cpuset.cpus;
+				do_echo 1 1 "$mems" /dev/cgroup/subgroup_1/cpuset.mems;
+			fi
+		fi
+		let "count = $count + 1"
+		echo "$count .. OK" >> $LOGFILE
+	done
+	echo "...executed $count times" >> $LOGFILE
+else
+	get_subgroup_path2 $subgroup_hiers
+	count=0
+	pathes[1]=""
+	for i in `seq 1 $subgroup_num`
+	do
+		get_subgroup_path1 $i
+		do_mkdir 1 1 $cur_subgroup_path1
+		if [ $subsystem -eq 2 ] || [ $subsystem -eq 7 ] ; then
+			if [ "$exist_cpuset" != "" ]; then
+				do_echo 1 1 "$cpus" "$cur_subgroup_path1""cpuset.cpus";
+				do_echo 1 1 "$mems" "$cur_subgroup_path1""cpuset.mems";
+			fi
+		fi
+		let "count = $count + 1"
+		pathes[$count]="$cur_subgroup_path1"
+		for j in `seq 2 $subgroup_hiers`
+		do
+			get_subgroup_path2 $j
+			do_mkdir 1 1 "$cur_subgroup_path1""$cur_subgroup_path2" 1
+			if [ $subsystem -eq 2 ] || [ $subsystem -eq 7 ] ; then
+				if [ "$exist_cpuset" != "" ]; then
+					do_echo 1 1 "$cpus" "$cur_subgroup_path1""$cur_subgroup_path2""cpuset.cpus";
+					do_echo 1 1 "$mems" "$cur_subgroup_path1""$cur_subgroup_path2""cpuset.mems";
+				fi
+			fi
+			let "count = $count + 1"
+			pathes[$count]="$cur_subgroup_path1""$cur_subgroup_path2"
+		done
+	done
+	echo "...mkdired $count times" >> $LOGFILE
+	
+	sleep 1
+	
+	case $attach_operation in
+	"1" )
+		for i in `seq 1 $count`
+		do
+			do_echo 1 1 $pid "${pathes[$i]}""tasks"
+		done
+		do_echo 1 1 $pid /dev/cgroup/tasks
+		;;
+	"2" )
+		pathes2[0]="/dev/cgroup/"
+		pathes2[1]="${pathes[$count]}"
+		pathes2[3]="/dev/cgroup/"
+		for i in `seq 1 $nlines`
+		do
+			j=$i
+			let "j = $j + 1"
+			cat "${pathes2[$i]}tasks" > $TMPFILE
+			nlines=`cat "$TMPFILE" | wc -l`
+			if [ $no_debug -ne 1 ]; then
+				echo "DEBUG: move $nlines processes from "$i"th path to "$j"th"
+			fi
+			for k in `seq 1 $nlines`
+			do
+				cur_pid=`sed -n "$k""p" $TMPFILE`
+				if [ -e /proc/$cur_pid/ ];then
+					do_echo 0 1 "$cur_pid" "${pathes[$j]}tasks"
+				fi
+			done
+		done
+		;;
+	"3" )
+		count2=$count
+		let "count2 = $count2 + 1"
+		pathes[0]="/dev/cgroup/"
+		pathes[$count2]="/dev/cgroup/"
+		for i in `seq 0 $count`
+		do
+			j=$i
+			let "j = $j + 1"
+			cat "${pathes[$i]}tasks" > $TMPFILE
+			nlines=`cat "$TMPFILE" | wc -l`
+			if [ $no_debug -ne 1 ]; then
+				echo "DEBUG: move $nlines processes from "$i"th path to "$j"th"
+			fi
+			for k in `seq 1 $nlines`
+			do
+				cur_pid=`sed -n "$k""p" $TMPFILE`
+				if [ -e /proc/$cur_pid/ ];then
+					do_echo 0 1 "$cur_pid" "${pathes[$j]}tasks"
+				fi
+			done
+		done
+		;;
+	*  )
+		;;
+	esac
+	reclaim_foundling;
+	for i in `seq 1 $count`
+	do
+		j=i
+		let "j = $count - $j + 1"
+		do_rmdir 1 1 ${pathes[$j]}
+	done
+fi
+
+do_rmdir 0 1 /dev/cgroup/subgroup_*
+
+sleep 1
+
+cleanup;
+do_kill 1 1 9 $pid
+sleep 1
+exit 0;
diff -urpN ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/cgroup_fj_testcases ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/cgroup_fj_testcases
--- ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/cgroup_fj_testcases	1969-12-31 19:00:00.000000000 -0500
+++ ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/cgroup_fj_testcases	2009-08-24 12:53:22.000000000 -0400
@@ -0,0 +1,194 @@
+function	1 1 1 1 1 2 3 2 1
+function	1 2 1 1 1 2 3 2 1
+function	1 1 1 2 1 2 3 2 1
+function	1 1 1 3 1 2 3 2 1
+function	1 1 1 4 1 2 3 2 1
+function	1 1 1 5 1 2 3 2 1
+function	1 1 1 6 1 2 3 2 1
+function	1 1 1 7 1 2 3 2 1
+function	1 1 1 8 1 2 3 2 1
+function	2 1 1 1 1 2 3 2 1
+function	2 2 1 1 1 2 3 2 1
+function	2 1 2 1 1 2 3 2 1
+function	2 1 1 2 1 2 3 2 1
+function	2 1 1 3 1 2 3 2 1
+function	2 1 1 4 1 2 3 2 1
+function	2 1 1 5 1 2 3 2 1
+function	2 1 1 6 1 2 3 2 1
+function	2 1 1 7 1 2 3 2 1
+function	2 1 1 8 1 2 3 2 1
+function	3 1 1 1 1 2 3 2 1
+function	3 2 1 1 1 2 3 2 1
+function	3 1 1 2 1 2 3 2 1
+function	3 1 1 3 1 2 3 2 1
+function	3 1 1 4 1 2 3 2 1
+function	3 1 1 5 1 2 3 2 1
+function	3 1 1 6 1 2 3 2 1
+function	3 1 1 7 1 2 3 2 1
+function	3 1 1 8 1 2 3 2 1
+function	4 1 1 1 1 2 3 2 1
+function	4 2 1 1 1 2 3 2 1
+function	4 1 1 2 1 2 3 2 1
+function	4 1 1 3 1 2 3 2 1
+function	4 1 1 4 1 2 3 2 1
+function	4 1 1 5 1 2 3 2 1
+function	4 1 1 6 1 2 3 2 1
+function	4 1 1 7 1 2 3 2 1
+function	4 1 1 8 1 2 3 2 1
+function	5 1 1 1 1 2 3 2 1
+function	5 2 1 1 1 2 3 2 1
+function	5 1 1 2 1 2 3 2 1
+function	5 1 1 3 1 2 3 2 1
+function	5 1 1 4 1 2 3 2 1
+function	5 1 1 5 1 2 3 2 1
+function	5 1 1 6 1 2 3 2 1
+function	5 1 1 7 1 2 3 2 1
+function	5 1 1 8 1 2 3 2 1
+function	6 1 1 1 1 2 3 2 1
+function	6 2 1 1 1 2 3 2 1
+function	6 1 1 2 1 2 3 2 1
+function	6 1 1 3 1 2 3 2 1
+function	6 1 1 4 1 2 3 2 1
+function	6 1 1 5 1 2 3 2 1
+function	6 1 1 6 1 2 3 2 1
+function	6 1 1 7 1 2 3 2 1
+function	6 1 1 8 1 2 3 2 1
+function	7 1 1 1 1 2 3 2 1
+function	7 2 1 1 1 2 3 2 1
+function	7 1 1 2 1 2 3 2 1
+function	7 1 1 3 1 2 3 2 1
+function	7 1 1 4 1 2 3 2 1
+function	7 1 1 5 1 2 3 2 1
+function	7 1 1 6 1 2 3 2 1
+function	7 1 1 7 1 2 3 2 1
+function	7 1 1 8 1 2 3 2 1
+function	8 1 1 1 1 2 3 2 1
+function	9 1 1 1 1 2 3 2 1
+function	9 2 1 1 1 2 3 2 1
+function	9 1 1 2 1 2 3 2 1
+function	9 1 1 3 1 2 3 2 1
+function	9 1 1 4 1 2 3 2 1
+function	9 1 1 5 1 2 3 2 1
+function	9 1 1 6 1 2 3 2 1
+function	9 1 1 7 1 2 3 2 1
+function	9 1 1 8 1 2 3 2 1
+function	10 1 1 1 1 2 3 2 1
+function	11 1 1 1 1 2 3 2 1
+function	11 2 1 1 1 2 3 2 1
+function	11 1 1 2 1 2 3 2 1
+function	11 1 1 3 1 2 3 2 1
+function	11 1 1 4 1 2 3 2 1
+function	11 1 1 5 1 2 3 2 1
+function	11 1 1 6 1 2 3 2 1
+function	11 1 1 7 1 2 3 2 1
+function	11 1 1 8 1 2 3 2 1
+function	12 1 1 1 1 2 3 2 1
+function	12 2 1 1 1 2 3 2 1
+function	12 1 1 2 1 2 3 2 1
+function	12 1 1 3 1 2 3 2 1
+function	12 1 1 4 1 2 3 2 1
+function	12 1 1 5 1 2 3 2 1
+function	12 1 1 6 1 2 3 2 1
+function	12 1 1 7 1 2 3 2 1
+function	12 1 1 8 1 2 3 2 1
+function	1 1 1 1 1 1 2 1 1
+function	1 1 1 1 1 2 2 1 1
+function	1 1 1 1 1 2 3 1 1
+function	1 1 1 1 1 2 5 1 1
+function	1 1 1 1 1 3 1 1 1
+function	1 1 1 1 1 3 2 1 1
+function	1 1 1 1 1 3 4 1 1
+function	1 1 1 1 1 4 3 1 1
+function	1 1 1 1 1 4 5 1 1
+function	1 1 1 1 2 1 1 1 1
+function	1 1 1 1 1 1 1 1 1
+function	1 1 1 1 1 1 3 2 1
+function	1 1 1 1 1 2 3 2 2
+function	1 1 1 1 1 2 3 2 3
+function	1 1 1 1 1 2 3 2 4
+function	1 1 1 1 1 2 3 2 5
+function	1 1 1 1 1 2 3 2 6
+function	1 1 1 1 1 2 3 2 7
+function	1 1 1 1 1 2 3 3 2
+function	1 1 1 1 1 2 3 4 2
+function	1 1 1 1 1 2 3 5 2
+function	1 1 1 1 1 2 3 6 2
+function	1 1 1 1 1 2 3 7 2
+function	1 1 1 2 1 2 3 2 2
+function	1 1 1 3 1 2 3 1 1
+function	1 1 1 3 1 2 3 1 2
+function	1 1 1 3 1 2 3 1 3
+function	1 1 1 3 1 2 3 2 1
+function	1 1 1 3 1 2 3 2 2
+function	1 1 1 3 1 2 3 2 3
+function	1 1 1 3 1 2 3 2 4
+function	1 1 1 3 1 2 3 2 5
+function	1 1 1 3 1 2 3 2 6
+function	1 1 1 3 1 2 3 2 7
+function	1 1 1 3 1 2 3 3 1
+function	1 1 1 3 1 2 3 3 2
+function	1 1 1 3 1 2 3 3 3
+function	1 1 1 3 1 2 3 4 2
+function	1 1 1 3 1 2 3 5 2
+function	1 1 1 3 1 2 3 6 2
+function	1 1 1 3 1 2 3 7 2
+function2	1
+function2	2
+function2	3
+function2	4
+function2	5
+function2	6
+function2	7
+function2	8
+function2	9
+function2	10
+function2	11
+function2	12
+function2	13
+stress	1 2 1 1 1
+stress	2 2 1 1 1
+stress	3 2 1 1 1
+stress	4 2 1 1 1
+stress	5 2 1 1 1
+stress	6 2 1 1 1
+stress	7 2 1 1 1
+stress	1 1 1 1 2
+stress	1 1 1 2 1
+stress	1 1 1 2 2
+stress	1 1 1 2 3
+stress	1 1 2 1 1
+stress	1 1 2 1 2
+stress	1 1 2 1 3
+stress	1 1 2 2 1
+stress	1 1 2 2 2
+stress	2 1 1 1 2
+stress	2 1 1 2 1
+stress	2 1 1 2 2
+stress	2 1 1 2 3
+stress	2 1 2 1 1
+stress	2 1 2 1 2
+stress	2 1 2 1 3
+stress	2 1 2 2 1
+stress	2 1 2 2 2
+stress	4 1 1 1 2
+stress	4 1 2 1 1
+stress	4 1 2 1 2
+stress	4 1 2 1 3
+stress	5 1 1 1 2
+stress	5 1 1 2 1
+stress	5 1 1 2 2
+stress	5 1 1 2 3
+stress	5 1 2 1 1
+stress	5 1 2 1 2
+stress	5 1 2 1 3
+stress	5 1 2 2 1
+stress	5 1 2 2 2
+stress	6 1 1 1 2
+stress	6 1 1 2 1
+stress	6 1 1 2 2
+stress	6 1 1 2 3
+stress	6 1 2 1 1
+stress	6 1 2 1 2
+stress	6 1 2 1 3
+stress	6 1 2 2 1
+stress	6 1 2 2 2
diff -urpN ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh
--- ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh	1969-12-31 19:00:00.000000000 -0500
+++ ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/cgroup_fj_utility.sh	2009-08-24 12:22:51.000000000 -0400
@@ -0,0 +1,633 @@
+#! /bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2009 FUJITSU LIMITED                                         ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+## Author: Shi Weihua <shiwh@cn.fujitsu.com>                                  ##
+##                                                                            ##
+################################################################################
+
+subsystem_str=""
+
+exist_subsystem()
+{
+	checksubsystem=""
+	case "$#" in
+	"0" )
+		checksubsystem=$subsystem_str
+		;;
+	"1" )
+		checksubsystem=$1
+		;;
+	"*" )
+		if [ "$#" -gt "1" ]; then
+			exit -1
+		fi
+		;;
+	esac
+
+	if [ "$checksubsystem" = "" ]; then
+		exit -1
+	fi
+	
+	exist=`grep -w $checksubsystem /proc/cgroups | cut -f1`;
+	if [ "$exist" = "" ]; then
+		exit 9 
+	fi
+}
+
+get_subsystem()
+{
+	case $subsystem in
+	"1" )
+		subsystem_str="debug";
+		exist_subsystem;
+		;;
+	"2" )
+		subsystem_str="cpuset";
+		exist_subsystem;
+		;;
+	"3" )
+		subsystem_str="ns";
+		exist_subsystem;
+		;;
+	"4" )
+		subsystem_str="cpu"
+		exist_subsystem;
+		;;
+	"5" )
+		subsystem_str="cpuacct";
+		exist_subsystem;
+		;;
+	"6" )
+		subsystem_str="memory";
+		exist_subsystem;
+		;;
+	"7" )
+		subsystem_str="all";
+		;;
+	"8" )
+		subsystem_str=""
+		;;
+	"9" )
+		subsystem_str="debug,debug";
+		exist_subsystem "debug";
+		;;
+	"10" )
+		subsystem_str="abc";
+		;;
+	"11" )
+		subsystem_str="freezer";
+		exist_subsystem;
+		;;
+	"12" )
+		subsystem_str="devices";
+		exist_subsystem;
+		;;
+	 *  )
+		return -1
+		;;
+	esac
+}
+
+get_remount_use()
+{
+	case $remount_use in
+	"1" )
+		remount_use_str="";
+		;;
+	"2" )
+		remount_use_str="remount";
+		;;
+	 *  )
+		return -1
+		;;
+	esac
+}
+
+get_noprefix_use()
+{
+	case $noprefix_use in
+	"1" )
+		noprefix_use_str="";
+		;;
+	"2" )
+		if [ $subsystem -ne 2 ]; then
+			return -1
+		fi
+		noprefix_use_str="noprefix";
+		;;
+	 *  )
+		return -1
+		;;
+	esac
+}
+
+get_release_agent_para()
+{
+	case $release_agent_para in
+	"1" )
+		release_agent_para_str="";
+		;;
+	"2" )
+		release_agent_para_str=" ";
+		;;
+	"3" )
+		release_agent_para_str="/root/cgroup_fj_release_agent";
+		;;
+	"4" )
+		release_agent_para_str="cgroup_fj_release_agent";
+		;;
+	"5" )
+		release_agent_para_str="/sbin/cgroup_fj_release_agent";
+		;;
+	"6" )
+		release_agent_para_str="/root/cgroup_fj_release_agent";
+		;;
+	"7" )
+		release_agent_para_str="/sbin/abc";
+		;;
+	"8" )
+		release_agent_para_str="/sbin/cgroup_fj_release_agent";
+		;;
+	 *  )
+		return -1
+		;;
+	esac
+}
+
+get_notify_on_release()
+{
+	case $notify_on_release in
+	"1" )
+		notify_on_release_str="0";
+		;;
+	"2" )
+		notify_on_release_str="1";
+		;;
+	"3" )
+		notify_on_release_str="2";
+		;;
+	"4" )
+		notify_on_release_str="-1";
+		;;
+	"5" )
+		notify_on_release_str="0ddd";
+		;;
+	"6" )
+		notify_on_release_str="1ddd";
+		;;
+	"7" )
+		notify_on_release_str="ddd1";
+		;;
+	 *  )
+		return -1
+		;;
+	esac
+}
+
+get_release_agent()
+{
+	case $release_agent_echo in
+	"1" )
+		release_agent_str="";
+		;;
+	"2" )
+		release_agent_str="/root/cgroup_fj_release_agent";
+		;;
+	"3" )
+		release_agent_str="cgroup_fj_release_agent";
+		;;
+	"4" )
+		release_agent_str="/sbin/cgroup_fj_release_agent";
+		;;
+	"5" )
+		release_agent_str="/root/cgroup_fj_release_agent";
+		;;
+	"6" )
+		release_agent_str="/sbin/abc";
+		;;
+	"7" )
+		release_agent_str="/sbin/cgroup_fj_release_agent";
+		;;
+	 *  )
+		return -1
+		;;
+	esac
+}
+
+# check the exit status, and exit or echo info.
+# exit status	expectted value	echo info	exit or not
+# 0		0		no		no
+# 0		1		yes	yes
+# not 0	0		yes	yes
+# not 0	1		no		no
+do_exit()
+{
+	if [ "$#" -ne "3" ]; then
+		echo "ERROR: exit failed,your parameter is wrong..Exiting test" >> $LOGFILE
+		exit -1
+	fi
+	
+	exit_here=$1
+	expectted=$2
+	exit_status=$3
+	
+	if [ $exit_status -eq 0 ] ;then
+		if [ $expectted -lt 1 ]; then
+			echo "								against with expectted" >> $LOGFILE
+			if [ $exit_here -ge 1 ]; then
+				cleanup;
+				exit -1
+			fi
+		fi
+	else
+		if [ $expectted -ge 1 ]; then
+			echo "								against with expectted" >> $LOGFILE
+			if [ $exit_here -ge 1 ]; then
+				cleanup;
+				exit -1
+			fi
+		else
+			if [ $exit_here -ge 1 ]; then
+				cleanup;
+				exit 0
+			fi
+		fi
+	fi
+}
+
+do_echo()
+{
+	if [ "$#" -ne "4" ]; then
+		echo "ERROR: echo failed,your parameter is wrong..Exiting test" >> $LOGFILE
+		exit -1
+	fi
+	
+	exit_here=$1
+	expectted=$2
+	value=$3
+	target=$4
+
+	if [ $no_debug -ne 1 ]; then
+		if [ $expectted -ge 1 ]; then
+			echo "\"echo $value > $target\" (expectted: success)" >> $LOGFILE
+		else
+			echo "\"echo $value > $target\" (expectted: fail)" >> $LOGFILE
+		fi
+	fi
+
+	`echo $value > $target` >> $LOGFILE 2>&1
+	do_exit $exit_here $expectted $?;
+}
+
+do_mkdir()
+{
+	if [ "$#" -ne "3" ] && [ "$#" -ne "4" ]; then
+		echo "ERROR: mkdir failed,your parameter is wrong..Exiting test" >> $LOGFILE
+		exit -1
+	fi
+	
+	exit_here=$1
+	expectted=$2
+	target=$3
+	parents=0
+	if [ "$#" -eq "4" ] && [ "$4" -ne 0 ]; then
+		parents=1
+	fi
+
+	if [ $no_debug -ne 1 ]; then
+		if [ $expectted -ge 1 ]; then
+			echo "\"mkdir $target\" (expectted: success)" >> $LOGFILE
+		else
+			echo "\"mkdir $target\" (expectted: fail)" >> $LOGFILE
+		fi
+	fi
+	
+	if [ $parents -ne "1" ] && [ -e $target ]; then
+		do_rmdir $exit_here 1 $target
+	fi
+	
+	if [ $parents -ne "1" ]; then
+		mkdir $target >> $LOGFILE 2>&1
+	else
+		mkdir -p $target >> $LOGFILE 2>&1
+	fi
+	do_exit $exit_here $expectted $?;
+}
+
+do_rmdir()
+{
+	if [ "$#" -lt "3" ]; then
+		echo "ERROR: rmdir failed,your parameter is wrong..Exiting test" >> $LOGFILE
+		exit -1
+	fi
+	
+	exit_here=$1
+	expectted=$2
+	target=$3
+
+	if ! [ -e $target ]; then
+		echo "INFO: $target is not exist" >> $LOGFILE
+		return
+	fi
+	
+	if [ $no_debug -ne 1 ]; then
+		if [ $expectted -ge 1 ]; then
+			echo "\"rmdir $target\" (expectted: success)" >> $LOGFILE
+		else
+			echo "\"rmdir $target\" (expectted: fail)" >> $LOGFILE
+		fi
+	fi
+	
+	rmdir $3 $4 $5 >> $LOGFILE 2>&1
+	do_exit $exit_here $expectted $?;
+}
+
+do_mount()
+{
+	if [ "$#" -ne "4" ] && [ "$#" -ne "5" ] ; then
+		echo "ERROR: mount failed,your parameter is wrong..Exiting test" >> $LOGFILE
+		exit -1
+	fi
+	
+	exit_here=$1
+	expectted=$2
+	para_o=$3
+	target=$4
+	something="cgroup"
+	if [ "$#" -eq "5" ]; then
+		something=$5
+	fi
+	
+	if [ $no_debug -ne 1 ]; then
+		if [ $expectted -ge 1 ]; then
+			echo "\"mount -t cgroup $para_o $something $target\" (expectted: success)" >> $LOGFILE
+		else
+			echo "\"mount -t cgroup $para_o $something $target\" (expectted: fail)" >> $LOGFILE
+		fi
+	fi
+	
+	mount -t cgroup $para_o $something $target >> $LOGFILE 2>&1
+	do_exit $exit_here $expectted $?;
+}
+
+do_umount()
+{
+	if [ "$#" -ne "3" ]; then
+		echo "ERROR: umount failed,your parameter is wrong..Exiting test" >> $LOGFILE
+		exit -1
+	fi
+	
+	exit_here=$1
+	expectted=$2
+	target=$3
+	
+	if [ $no_debug -ne 1 ]; then
+		if [ $expectted -ge 1 ]; then
+			echo "\"umount $target\" (expectted: success)" >> $LOGFILE
+		else
+			echo "\"umount $target\" (expectted: fail)" >> $LOGFILE
+		fi
+	fi
+	
+	umount $target >> $LOGFILE 2>&1
+	do_exit $exit_here $expectted $?;
+}
+
+do_mv()
+{
+	if [ "$#" -ne "4" ]; then
+		echo "ERROR: mv failed,your parameter is wrong..Exiting test" >> $LOGFILE
+		exit -1
+	fi
+	
+	exit_here=$1
+	expectted=$2
+	source=$3
+	target=$4
+	
+	if [ $no_debug -ne 1 ]; then
+		if [ $expectted -ge 1 ]; then
+			echo "\"mv $source $target\" (expectted: success)" >> $LOGFILE
+		else
+			echo "\"mv $source $target\" (expectted: fail)" >> $LOGFILE
+		fi
+	fi
+	
+	mv $source $target >> $LOGFILE 2>&1
+	do_exit $exit_here $expectted $?;
+}
+
+do_kill()
+{
+	if [ "$#" -ne "4" ]; then
+		echo "ERROR: kill failed,your parameter is wrong..Exiting test" >> $LOGFILE
+		exit -1
+	fi
+	
+	exit_here=$1
+	expectted=$2
+	signo=$3
+	pid=$4
+
+	if ! [ -e /proc/$pid/ ];then
+		return
+	fi	
+
+	if [ $no_debug -ne 1 ]; then
+		if [ $expectted -ge 1 ]; then
+			echo "\"kill -$signo $pid\" (expectted: success)" >> $LOGFILE
+		else
+			echo "\"kill -$signo $pid\" (expectted: fail)" >> $LOGFILE
+		fi
+	fi
+
+	kill -s $signo $pid >> $LOGFILE 2>&1
+	do_exit $exit_here $expectted $?;
+}
+
+setup()
+{
+	if [ -e /dev/cgroup ]; then
+		cleanup;
+	fi
+	do_mkdir 1 1 /dev/cgroup
+	
+	if [ -e $TESTROOT/cgroup_fj_release_agent ]
+	then
+		cp -f $TESTROOT/cgroup_fj_release_agent /sbin
+		chmod a+x /sbin/cgroup_fj_release_agent
+		cp -f $TESTROOT/cgroup_fj_release_agent /root
+		chmod a+x /root/cgroup_fj_release_agent
+	else
+		echo "ERROR: $TESTROOT/cgroup_fj_release_agent isn't exist..Exiting test" >> $LOGFILE
+		exit -1;
+	fi
+
+	if [ $release_agent_para -eq 8 ] || [ $release_agent_echo -eq 7 ]; then
+		chmod a-x /sbin/cgroup_fj_release_agent
+	fi
+	
+	if [ -e $TESTROOT/cgroup_fj_proc ]
+	then
+		chmod a+x $TESTROOT/cgroup_fj_proc
+	else
+		echo "ERROR: $TESTROOT/cgroup_fj_proc isn't exist..Exiting test" >> $LOGFILE
+		exit -1;
+	fi
+}
+
+cleanup()
+{
+	if [ $no_debug -ne 1 ]; then
+		echo "INFO: we now cleanup ..." >> $LOGFILE
+	fi
+
+	export LANG=en_US.UTF-8
+
+	rm -f /sbin/cgroup_fj_release_agent 2>/dev/null
+	rm -f /root/cgroup_fj_release_agent 2>/dev/null
+
+	killall -9 cgroup_fj_proc 1>/dev/null 2>&1;
+
+	if [ -e /dev/cgroup/subgroup_1 ]; then
+		cat /dev/cgroup/subgroup_1/tasks > $TMPFILE
+		nlines=`cat $TMPFILE | wc -l`
+		for i in `seq 1 $nlines`
+		do
+			cur_pid=`sed -n "$i""p" $TMPFILE`
+			if [ -e /proc/$cur_pid/ ];then
+				do_echo 0 1 "$cur_pid" /dev/cgroup/tasks
+			fi
+		done
+		do_rmdir 0 1 /dev/cgroup/subgroup_*
+	fi
+	
+	if [ -e $TMPFILE ]; then
+		rm -f $TMPFILE 2>/dev/null
+	fi
+
+	mount_str="`mount -l | grep /dev/cgroup`"
+	if [ "$mount_str" != "" ]; then
+		do_umount 0 1 /dev/cgroup
+	fi
+	
+	if [ -e /dev/cgroup ]; then
+		do_rmdir 0 1 /dev/cgroup
+	fi
+}
+
+reclaim_foundling()
+{
+	if ! [ -e /dev/cgroup/subgroup_1 ]; then
+		return
+	fi
+	foundlings=0
+	cat `find /dev/cgroup/subgroup_* -name "tasks"` > $TMPFILE
+	nlines=`cat "$TMPFILE" | wc -l`
+	for k in `seq 1 $nlines`
+	do
+		cur_pid=`sed -n "$k""p" $TMPFILE`
+		if [ -e /proc/$cur_pid/ ];then
+			echo "ERROR: pid $cur_pid reclaimed"
+			do_echo 0 1 "$cur_pid" "/dev/cgroup/tasks"
+			let "foundlings = $foundlings + 1"
+		fi
+	done
+
+	if [ $foundlings -ne 0 ]; then
+		echo "ERROR: some processes lost in subgroups's tasks, now they are reclaimed."
+	fi 
+}
+
+mkdir_subgroup()
+{
+	if ! [ -e /dev/cgroup ]; then
+		echo "ERROR: /dev/cgroup isn't exist..Exiting test" >> $LOGFILE
+		exit -1;
+	fi
+
+	do_mkdir 1 1 /dev/cgroup/subgroup_1
+}
+
+mount_cgroup ()
+{
+	expectted=1
+	PARAMETER_O="";
+	if [ $subsystem -eq 10 ]; then
+		expectted=0
+	fi
+	if [ "$subsystem_str" != "" ]; then
+		PARAMETER_O="$subsystem_str"
+	fi
+	if [ "$noprefix_use_str" != "" ]; then
+		if [ "$PARAMETER_O" != "" ]; then
+			PARAMETER_O="$PARAMETER_O"",""$noprefix_use_str"
+		else
+			PARAMETER_O="$noprefix_use_str"
+		fi
+	fi
+	if [ "$release_agent_para_str" != "" ]; then
+		if [ "$PARAMETER_O" != "" ]; then
+			PARAMETER_O="$PARAMETER_O"",release_agent=""$release_agent_para_str"
+		else
+			PARAMETER_O="release_agent=""$release_agent_para_str"
+		fi
+	fi
+	if [ "$remount_use_str" != "" ]; then
+		if [ "$PARAMETER_O" != "" ]; then
+			do_mount 1 1 "-o$PARAMETER_O" /dev/cgroup
+			PARAMETER_O="$PARAMETER_O"",""$remount_use_str"
+		else
+			do_mount 1 1 "" /dev/cgroup
+			PARAMETER_O="$remount_use_str"
+		fi
+		sleep 1
+	fi
+
+	if [ "$PARAMETER_O" != "" ]; then
+		PARAMETER_O="-o""$PARAMETER_O"
+	fi
+	
+	do_mount 1 $expectted "$PARAMETER_O" /dev/cgroup
+}
+
+check_para()
+{
+	get_subsystem;
+	ret1=$?
+	get_remount_use;
+	ret2=$?
+	get_noprefix_use;
+	ret3=$?
+	get_release_agent_para;
+	ret4=$?
+	get_notify_on_release;
+	ret5=$?
+	get_release_agent;
+	ret6=$?
+
+	if [ $ret1 -ne 0 ] || [ $ret2 -ne 0 ] || [ $ret3 -ne 0 ] || [ $ret4 -ne 0 ] || [ $ret5 -ne 0 ] || [ $ret6 -ne 0 ] 
+	then
+		echo "ERROR: Wrong inputed parameter..Exiting test" >> $LOGFILE
+		return -1
+	fi
+
+	return 0
+}
diff -urpN ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/Makefile ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/Makefile
--- ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/Makefile	2009-08-23 11:07:41.000000000 -0400
@@ -0,0 +1,19 @@
+CFLAGS += -Wall -O2 -Wextra
+
+SRCS    = $(wildcard *.c)
+TARGETS = $(patsubst %.c,%,$(SRCS))
+
+all:	$(TARGETS)
+
+install:
+
+test:
+	@./run_cgroup_test_fj.sh
+
+clean:
+	rm -f $(TARGETS) *.o
+
+install:
+	@set -e; for i in $(TARGETS) *.sh; do ln -f $$i ../../../bin/$$i ; chmod +x $$i ; done
+	ln -f cgroup_fj_release_agent ../../../bin/cgroup_fj_release_agent
+	ln -f cgroup_fj_testcases ../../../bin/cgroup_fj_testcases 
diff -urpN ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/README ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/README
--- ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/README	1969-12-31 19:00:00.000000000 -0500
+++ ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/README	2009-08-23 10:08:01.000000000 -0400
@@ -0,0 +1,56 @@
+
+TEST SUITE:
+
+The directory cgroup_fj contains the tests related to the cgroups.
+
+There are total 194 testcases that have been added. These testcases 
+contain the basis operation test and stress test of cgroups.
+
+NOTE: the test can be run by root only.
+
+TESTS AIM:
+
+The aim of the tests is to test the functionality of cgroups.
+
+FILES DESCRIPTION:
+
+run_cgroup_test_fj.sh
+--------------------
+This script runs all the 194 testcases.
+
+cgroup_fj_proc.c
+--------------------
+The program creates child process till catched a signal SIGUSR1.
+
+cgroup_fj_utility.sh
+--------------------
+Contains common functions for function test and stress test.
+
+cgroup_fj_release_agent
+--------------------
+Used for the cgroup option of release_agent.
+
+cgroup_fj_function.sh
+--------------------
+This script runs a function test.
+
+cgroup_fj_function2.sh
+--------------------
+This script runs a function test which not be covered by cgroup_fj_function.sh.
+
+cgroup_fj_stress.sh
+--------------------
+This script runs a stress test.
+
+cgroup_fj_testcases
+--------------------
+Prestored test cases for function test and stress test.
+
+Makefile
+--------------------
+The usual makefile for this directory
+
+README
+------
+The one you have gone through.
+
diff -urpN ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
--- ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh	1969-12-31 19:00:00.000000000 -0500
+++ ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh	2009-08-24 12:07:35.000000000 -0400
@@ -0,0 +1,135 @@
+#! /bin/sh
+
+################################################################################
+##                                                                            ##
+## Copyright (c) 2009 FUJITSU LIMITED                                         ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+## Author: Shi Weihua <shiwh@cn.fujitsu.com>                                  ##
+##                                                                            ##
+################################################################################
+cd $LTPROOT/testcases/bin
+
+export TCID="cgroup_test_fj"
+export TST_TOTAL=194
+export TST_COUNT=1
+
+export TESTROOT=`pwd`
+export LOGFILE=$LTPROOT/output/cgroup_fj_log_`date +%F`.txt
+export TMPFILE=$TESTROOT/tmp_tasks
+export CASENO1=0
+export CASENO2=0
+
+if [ "$UID" -ne 0 ]; then
+	echo "***error***:you must use root to test"
+	exit -1
+fi
+
+if ! [ -f /proc/cgroups ]; then
+	echo "***error***:you must enable cgroup config in kernel";
+	exit -3;
+fi
+
+if [ ! -x $TESTROOT/cgroup_fj_proc ]; then
+	echo "***warning***:file \"cgroup_fj_proc\" is not exist or not executable";
+	echo "please do make and check execution permission"
+	exit -4;
+fi
+
+CPUSET=`grep -w cpuset /proc/cgroups | cut -f1`;
+DEBUG=`grep -w debug /proc/cgroups | cut -f1`;
+NS=`grep -w ns /proc/cgroups | cut -f1`;
+CPU=`grep -w cpu /proc/cgroups | cut -f1`;
+CPUACCT=`grep -w cpuacct /proc/cgroups | cut -f1`;
+MEMORY=`grep -w memory /proc/cgroups | cut -f1`;
+FREEZER=`grep -w freezer /proc/cgroups | cut -f1`
+DEVICES=`grep -w devices /proc/cgroups | cut -f1`
+SUBSYSCOMPILED="";
+if [ "$CPUSET" = "cpuset" ]; then
+	SYBSYSCOMPILED="cpuset,"
+fi
+if [ "$DEBUG" = "debug" ]; then
+	SYBSYSCOMPILED="$SYBSYSCOMPILED debug,"
+fi
+if [ "$NS" = "ns" ]; then
+	SYBSYSCOMPILED="$SYBSYSCOMPILED ns,"
+fi
+if [ "$CPU" = "cpu" ]; then
+	SYBSYSCOMPILED="$SYBSYSCOMPILED cpu,"
+fi
+if [ "$CPUACCT" = "cpuacct" ]; then
+	SYBSYSCOMPILED="$SYBSYSCOMPILED cpuacct,"
+fi
+if [ "$MEMORY" = "memory" ]; then
+	SYBSYSCOMPILED="$SYBSYSCOMPILED memory,"
+fi
+if [ "$FREEZER" = "freezer" ]; then
+	SYBSYSCOMPILED="$SYBSYSCOMPILED freezer,"
+fi
+if [ "$DEVICES" = "devices" ]; then
+        SYBSYSCOMPILED="$SYBSYSCOMPILED devices,"
+fi
+if [ "$SYBSYSCOMPILED" = "" ];then	# Warning and exit if all cgroup subsystem are not compiled
+	echo "CONTROLLERS TESTCASES: WARNING";
+	echo "Kernel does not support for any cgroup subsystem";
+	echo "Skipping all controllers testcases....";
+	exit -2;
+fi
+
+echo "Now, we start the test for cgroup...";
+
+rm -f $LOGFILE 2>/dev/null
+echo `date` > $LOGFILE
+echo `uname -a` >> $LOGFILE
+
+echo "" >> $LOGFILE
+echo "Now, we start the test for basic function of cgroup..." >> $LOGFILE
+
+nlines=`cat cgroup_fj_testcases | wc -l`
+for i in `seq 1 $nlines`
+do
+	CASETYPE=`sed -n "$i""p" cgroup_fj_testcases | cut -f1`
+	CASECMD=`sed -n "$i""p" cgroup_fj_testcases | cut -f2`
+	echo $CASETYPE | grep "#"
+	if [ $? -ne 0 ]; then
+		case $CASETYPE in
+		"function" )
+			let "CASENO1 = $CASENO1 + 1"
+			export CASENO1=$CASENO1
+			$TESTROOT/cgroup_fj_function.sh $CASECMD
+			;;
+		"function2" )
+			let "CASENO1 = $CASENO1 + 1"
+			export CASENO1=$CASENO1
+			$TESTROOT/cgroup_fj_function2.sh $CASECMD
+			;;
+		"stress" )
+			let "CASENO2 = $CASENO2 + 1"
+			export CASENO2=$CASENO2
+			$TESTROOT/cgroup_fj_stress.sh $CASECMD
+			;;
+		esac
+
+		ret=$?
+		if [ $ret -eq 0 ]; then
+			tst_resm TPASS "case$i(`sed -n "$i""p" cgroup_fj_testcases`)    PASS"
+		elif [ $ret -ne 9 ]; then
+			tst_resm TFAIL "case$i(`sed -n "$i""p" cgroup_fj_testcases`)    FAIL"
+		fi
+	fi
+done
+
+exit 0;
diff -urpN ltp-full-20090731.orig/testcases/kernel/controllers/Makefile ltp-full-20090731.cg/testcases/kernel/controllers/Makefile
--- ltp-full-20090731.orig/testcases/kernel/controllers/Makefile	2009-07-30 13:27:58.000000000 -0400
+++ ltp-full-20090731.cg/testcases/kernel/controllers/Makefile	2009-08-23 10:34:45.000000000 -0400
@@ -12,6 +12,7 @@ endif
 ifdef CROSS_COMPILE
 ifeq ($(CHECK_CGROUP),cgroup)
 SUBDIRS += cgroup
+SUBDIRS += cgroup_fj
 SUBDIRS += cpuctl
 SUBDIRS += cpuctl_fj
 SUBDIRS += memctl
@@ -24,6 +25,7 @@ endif
 else
 ifeq ($(CHECK_CGROUP),cgroup)
 SUBDIRS += cgroup
+SUBDIRS += cgroup_fj
 else
 $(info "Kernel is not compiled with control cgroup support")
 endif









------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
