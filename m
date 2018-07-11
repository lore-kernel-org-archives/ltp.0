From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 11 Jul 2018 03:54:36 -0400 (EDT)
Subject: [LTP] [PATCH] open08: calling tst_get_bad_addr from LTP API
In-Reply-To: <CAEemH2fMr2Z1+wJqVnfXnTTSv6nx8J-QgWn8NKyn3Y7hY82eMg@mail.gmail.com>
References: <20180711051645.5075-1-liwang@redhat.com>
 <CAEemH2fOxm=CCNnfi_+POsFqapX_LY4siRA=+7OEiDJtVCSXxg@mail.gmail.com>
 <1988800005.31820575.1531294121616.JavaMail.zimbra@redhat.com>
 <CAEemH2fMr2Z1+wJqVnfXnTTSv6nx8J-QgWn8NKyn3Y7hY82eMg@mail.gmail.com>
Message-ID: <1548950279.31825428.1531295676218.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- Original Message -----
> On Wed, Jul 11, 2018 at 3:28 PM, Jan Stancek <jstancek@redhat.com> wrote:
> >
> >
> > ----- Original Message -----
> >> Maybe we misled by the code comments before, after thinking over, I
> >> guess the "outside your accessible address space" != "outside of
> >> process mapped space". So we don't need to do map/unmap to satisfy
> >> that.
> >
> > That may be the case, I changed it on purpose to match that comment.
> > Though as you pointed out PROT_NONE might be enough too.
> >
> > Is the motivation for your patch to re-use existing function
> 
> Yes, firstly my motivation is to re-use the existing function. But then I
> realized that maybe the original author misunderst
> ​oo​
> d the EFAULT error in open().
> 
> So I find open(2) manual and get this:
> "EFAULT pathname points outside your *accessible* address space."
> 
> ​Then I think maybe we need match the manual but not the code comments.

I'd say we match it already (in stronger form than PROT_NONE).

I don't object to re-using LTP function. Can you send v2
that updates also the comment please?

Regards,
Jan
