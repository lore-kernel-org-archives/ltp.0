From: Li Wang <liwang@redhat.com>
Date: Fri, 4 Dec 2015 13:55:10 +0800
Subject: [LTP] [PATCH 2/2] hugetlb: checking if hugepage is supported on
	target system
In-Reply-To: <20151203160829.GB20797@rei.lan>
References: <1448612328-2094-1-git-send-email-liwang@redhat.com>
 <1448612328-2094-2-git-send-email-liwang@redhat.com>
 <20151203160829.GB20797@rei.lan>
Message-ID: <CAEemH2eWS+pPYoOZEfKDzBhHP8Jgmq0xE1empmHa-dPcAmJgSA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Fri, Dec 4, 2015 at 12:08 AM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > -static void setup(void)
> > +void setup(void)
>
> This is wrong. What you should do instead is:
>
> * Remove the cleanup() and setup() definitions from the header from lib/
>
> * Change the getipckey() and getuserid() to have the callback pointer as
>   their first parameter and pass the cleanup callback in the
>   testcases.
>

ok, great. I would like to change that. patch V2 will be threw out.


-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151204/55a132c1/attachment.html>
