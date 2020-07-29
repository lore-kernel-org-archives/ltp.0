From: Li Wang <liwang@redhat.com>
Date: Wed, 29 Jul 2020 20:07:11 +0800
Subject: [LTP] [PATCH v2 1/3] lib: add function to check for kernel
 lockdown
In-Reply-To: <678ed5c9-d678-6673-666b-05b999567977@redhat.com>
References: <20200728162207.332109-1-ernunes@redhat.com>
 <CAEemH2d+EOzF8aKAkpsnUO1GqgPh3J40RBDXyBg0E5NC8nrSuw@mail.gmail.com>
 <678ed5c9-d678-6673-666b-05b999567977@redhat.com>
Message-ID: <CAEemH2d3Ji_oPT2O2sgdwvzMGc9YE_C3OLcR-h=zJivrLFnJdg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > I prefer to add a macro definition in the header file instead of this ^.
> >     #define PATH_LOCKDOWN  "/sys/kernel/security/lockdown"
>
> I'm ok with that, do you want me to submit another version like this or
> can you change while applying?
>

No needed for a new version, I can help do that.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200729/0a6edb69/attachment.htm>
