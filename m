Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SUqVD-0000Hk-OZ
	for ltp-list@lists.sourceforge.net; Thu, 17 May 2012 02:31:43 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SUqVD-0005Ch-3T
	for ltp-list@lists.sourceforge.net; Thu, 17 May 2012 02:31:43 +0000
Received: by obhx4 with SMTP id x4so2504964obh.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 May 2012 19:31:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FB45E98.3010506@cn.fujitsu.com>
References: <20120516145353.GA12228@saboteur.suse.cz>
	<1337219962-5782-1-git-send-email-penght@cn.fujitsu.com>
	<4FB45E98.3010506@cn.fujitsu.com>
Date: Wed, 16 May 2012 19:31:37 -0700
Message-ID: <CAGH67wSxwhPXQ_j5ryRQe4-en-wYf3iLUgrn9xtcQ54dR1FsaA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v2] ltp-pan.c: fix error of Total Tests
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
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

On Wed, May 16, 2012 at 7:12 PM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
> On 05/17/2012 09:59 AM, Peng Haitao wrote:
>
>> When execvp() fails, the testcases is counted in Total Tests, but not
>> added in logfile. In fact the testcases result should be added in logfile.
>
> I prefer adding this for matching the Total Tests amount.
> So,
>
> Acked-by: Wanlong Gao <gaownalong@cn.fujitsu.com>

    It's nice that this is finally being fixed. This is one issue that
has been outstanding for several years that needed to be resolved (I
noticed it during/after I developed the execltp python script).
Thanks!
-Garrett

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
