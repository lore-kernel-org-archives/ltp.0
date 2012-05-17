Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SUqdR-0000m7-3g
	for ltp-list@lists.sourceforge.net; Thu, 17 May 2012 02:40:13 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SUqdQ-0000Ct-EI
	for ltp-list@lists.sourceforge.net; Thu, 17 May 2012 02:40:13 +0000
Received: by obhx4 with SMTP id x4so2516122obh.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 May 2012 19:40:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGH67wTa2Y6mXP9Wv229s8Wdzp57uN=hcB63eEvW6Ud0osdUOw@mail.gmail.com>
References: <20120516145353.GA12228@saboteur.suse.cz>
	<1337219962-5782-1-git-send-email-penght@cn.fujitsu.com>
	<4FB45E98.3010506@cn.fujitsu.com>
	<CAGH67wSxwhPXQ_j5ryRQe4-en-wYf3iLUgrn9xtcQ54dR1FsaA@mail.gmail.com>
	<4FB46381.2010400@cn.fujitsu.com>
	<CAGH67wTa2Y6mXP9Wv229s8Wdzp57uN=hcB63eEvW6Ud0osdUOw@mail.gmail.com>
Date: Wed, 16 May 2012 19:40:06 -0700
Message-ID: <CAGH67wStJk_mqT46zqJ5FPNHLEeBjcyPo6i050xMwmpCm5aoBQ@mail.gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

On Wed, May 16, 2012 at 7:39 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Wed, May 16, 2012 at 7:33 PM, Wanlong Gao <gaowanlong@cn.fujitsu.com> =
wrote:
>> On 05/17/2012 10:31 AM, Garrett Cooper wrote:
>>
>>> On Wed, May 16, 2012 at 7:12 PM, Wanlong Gao <gaowanlong@cn.fujitsu.com=
> wrote:
>>>> On 05/17/2012 09:59 AM, Peng Haitao wrote:
>>>>
>>>>> When execvp() fails, the testcases is counted in Total Tests, but not
>>>>> added in logfile. In fact the testcases result should be added in log=
file.
>>>>
>>>> I prefer adding this for matching the Total Tests amount.
>>>> So,
>>>>
>>>> Acked-by: Wanlong Gao <gaownalong@cn.fujitsu.com>
>>>
>>> =A0 =A0 It's nice that this is finally being fixed. This is one issue t=
hat
>>> has been outstanding for several years that needed to be resolved (I
>>> noticed it during/after I developed the execltp python script).
>>
>>
>> So, Garrett, you can ACK this?
>
> I will ACK the sentiment, but I prefer to test it in order to ensure
> that it actually works...
>
> You can easily trigger this problem with the following spoofed runtest sc=
enario:
>
> aok echo "hello"
> donotexist donotexist
> exit_quickly exit 1
> true true
>
> The first will fail success with "hello" output, the second should

s/fail success/pass/

> fail with ENOENT, the third will fail without output, and the fourth
> should success with output.
>
> If this functions as I described above, I'll be more than happy to ACK
> the patch.
>
> Thanks!
> -Garrett

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
