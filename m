From: wangxin (CQ) <wangxin410@huawei.com>
Date: Wed, 28 Apr 2021 03:26:46 +0000
Subject: [LTP] =?gb2312?b?tPC4tDogW1BBVENIXSBvcGVucG9zaXgvY29uZm9ybWFu?=
 =?gb2312?b?Y2UvaW50ZXJmYWNlczogQ29ycmVjdCB0eXBvcw==?=
In-Reply-To: <YIhkBsRClMPkyM4Y@pevik>
References: <1619491883-69694-1-git-send-email-wangxin410@huawei.com>
 <YIhkBsRClMPkyM4Y@pevik>
Message-ID: <781c7f83980f45ffaefa3d93dff9f4a5@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
	
I'm really sorry. Later, I checked the steps of making and submitting a patch. 
The reason is that when I checked the patch format using the tool, some format errors were reported. 
However, I modified the patch format in an incorrect way (although the tool showed no error after the modification). 
I swear there will be no such mistake this time, and I'm really sorry.


Kind regards,
Wang Xin

-----????-----
???: Petr Vorel [mailto:pvorel@suse.cz] 
????: 2021?4?28? 3:21
???: wangxin (CQ) <wangxin410@huawei.com>
??: ltp@lists.linux.it
??: Re: [LTP][PATCH] openposix/conformance/interfaces: Correct typos

Hi Xin,

> Types in the name of the temporary files: For example, in 
> aio_cancel/8-1.c file,
> pts_aio_cancel_1_1 -> pts_aio_cancel_8_1.
> Others like this have been modified.

This patch is also not applicable with git am. Not sure what you do wrong, but simple 'git format-patch origin/master' should work.

Kind regards,
Petr
