From: Gao =?unknown-8bit?b?TWVpdGFv77yI6auY546r5rab77yJ?= <meitaogao@asrmicro.com>
Date: Fri, 15 Jan 2021 08:29:40 +0000
Subject: [LTP] =?utf-8?b?562U5aSNOiAgTFRQIHRlc3RjYXNlKHN5c2N0bDAyKSBmYWls?=
 =?utf-8?q?ed?=
In-Reply-To: <f3136f18-edd5-08b7-a720-72baeeed7fbc@jv-coder.de>
References: <0efaa481ffd24bc48fd41385159be66c@exch01.asrmicro.com>
 <f3136f18-edd5-08b7-a720-72baeeed7fbc@jv-coder.de>
Message-ID: <57bd563d22b642ec8618fc4f45e2811e@exch01.asrmicro.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joery:

	Thanks for your information and clearing this out, Ah, I am not alone with this.
	After I checked this patch (7f2923c), found that it seem be necessary , so patch it into my codebase.


Best wishes.
-----------------------------------
Best Regards
Meitao Gao
021-6109-2999 ext. 8300
------------------------------------



-----????-----
???: Joerg Vehlow [mailto:lkml@jv-coder.de] 
????: 2021?1?15? 14:14
???: Gao Meitao?????; ltp@lists.linux.it; Cyril Hrubis
??: Re: [LTP] LTP testcase(sysctl02) failed

Hi Gao,

On 12/24/2020 6:56 AM, Gao Meitao????? wrote:
>
> after investigated it, this testcase is for bufffer overflow, I 
> checked source code (kernel 4.19),
>
> all of required patched had been applied, I dig into it and found new 
> patch applied as flow , that might make testcase failed
>
> so is this testcase out of date or something wrong wih my kernel ?
>
> who can help me figure this out? Thanks in advance.
>
I also saw this on 4.19. From the mailing list of the kernel, it looks like there was some confusion when they ported the patches back to 4.19.
I do not find the mails on the mailing list anymore. But the commit 7f2923c from master is missing IIRC.
Christian Brauner made two changes:
1. Prevent over and underflow by just keeping the old value (7f2923c together with 32a5ad9c). This introduced a kasan bug fixed in 9002b21 2. Return EINVAL, if an overflow or underflow of the new value is detected (e260ad01f)

 From what I remember Christian wanted the first change completely backported to 4.19 (7f2923c, 32a5ad9c and 9002b21) and he wanted to omit the change done in e260ad01f, because that changed the behavior of the interface towards the user.
But when the changed were backported to 4.19, the commit 32a5ad9c,
9002b21 and e260ad01f were backported. Since 7f2923c is the commit, that really enables over- and underflow detection, this is not backported and all the other commit (including e260ad01f) have no effect.

At the time I found this, I had no time to find out how and where to report this.
@Cyril I guess you may know how and who to report this to?

J?rg
