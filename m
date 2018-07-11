From: Li Wang <liwang@redhat.com>
Date: Wed, 11 Jul 2018 15:41:50 +0800
Subject: [LTP] [PATCH] open08: calling tst_get_bad_addr from LTP API
In-Reply-To: <1988800005.31820575.1531294121616.JavaMail.zimbra@redhat.com>
References: <20180711051645.5075-1-liwang@redhat.com>
 <CAEemH2fOxm=CCNnfi_+POsFqapX_LY4siRA=+7OEiDJtVCSXxg@mail.gmail.com>
 <1988800005.31820575.1531294121616.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2fMr2Z1+wJqVnfXnTTSv6nx8J-QgWn8NKyn3Y7hY82eMg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Wed, Jul 11, 2018 at 3:28 PM, Jan Stancek <jstancek@redhat.com> wrote:
>
>
> ----- Original Message -----
>> Maybe we misled by the code comments before, after thinking over, I
>> guess the "outside your accessible address space" != "outside of
>> process mapped space". So we don't need to do map/unmap to satisfy
>> that.
>
> That may be the case, I changed it on purpose to match that comment.
> Though as you pointed out PROT_NONE might be enough too.
>
> Is the motivation for your patch to re-use existing function

Yes, firstly my motivation is to re-use the existing function. But then I
realized that maybe the original author misunderst
​oo​
d the EFAULT error in open().

So I find open(2) manual and get this:
"EFAULT pathname points outside your *accessible* address space."

​Then I think maybe we need match the manual but not the code comments.

That's all what I thought.​


> or have you hit some problem with map/unmap?

No, no other issues.


>
> Regards,
> Jan



-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180711/a2caab52/attachment.html>
