Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Diwakar.Sharma@in.bosch.com>) id 1WhFTN-0001KT-Jm
	for ltp-list@lists.sourceforge.net; Mon, 05 May 2014 09:46:09 +0000
Received: from imta22.fe.bosch.de ([139.15.243.26])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WhFTL-0001q6-69
	for ltp-list@lists.sourceforge.net; Mon, 05 May 2014 09:46:09 +0000
Received: from smtp6-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta22.fe.bosch.de (Postfix) with ESMTP id 04CE084024D
	for <ltp-list@lists.sourceforge.net>;
	Mon,  5 May 2014 11:27:06 +0200 (CEST)
Received: from vsmta13.fe.internet.bosch.com (unknown [10.4.98.53])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 37B1515801AC
	for <ltp-list@lists.sourceforge.net>;
	Mon,  5 May 2014 11:26:59 +0200 (CEST)
Received: from localhost (vsgw2.fe.internet.bosch.com [10.4.98.13])
	by vsmta13.fe.internet.bosch.com (Postfix) with SMTP id 148F9600670
	for <ltp-list@lists.sourceforge.net>;
	Mon,  5 May 2014 11:26:59 +0200 (CEST)
From: "Diwakar Sharma (RBEI/ECF3)" <Diwakar.Sharma@in.bosch.com>
Date: Mon, 5 May 2014 14:52:35 +0800
Message-ID: <46CD92664333704E8A06E512A60A9E9F2AD2C0B12F@SGPMBX02.APAC.bosch.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] - Kernel - tunable max_map_count test failure -
 20140115-46-g2368cd4
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi,

I was getting the max_map_count test failed. It looked to me failing at filter_map function. The platform I'm working on is an i686 architecture running on Virtualbox.
I added below additional macro condition and it's passing now. I want to understand if not including i686/386 was intentional originally for some reason? Also vdso part I added additionaly.

#elif defined(__i686__) || defined(__i386__)
static int filter_map(char *line)
{
        char buf[BUFSIZ];
        int ret;

        ret = sscanf(line, "%*p-%*p %*4s %*p %*2d:%*2d %*d %s", buf);
        if (ret != 1)
                return 0;

        return ((strcmp(buf, "[vdso]") == 0) | (strcmp(buf, "[vsyscall]") == 0));
}


On another similar architecture (but the actual h/w board), the same code gives messages like "4096 map entries in total, but expected 4096 entries" and reported FAIL, implying map_count and max_maps is same ( Contrary to map_count==max_maps+1 ). How do we analyze this scenario? Does this mean it is not exceeding by one for sysctl setting? How to verify that.


Thanks and Regards
Diwakar Sharma



------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
