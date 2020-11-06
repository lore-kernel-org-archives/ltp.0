From: Li Wang <liwang@redhat.com>
Date: Fri, 6 Nov 2020 18:32:38 +0800
Subject: [LTP] [PATCH v4 2/2] lib/tst_kconfig: Make use of boolean
 expression eval
In-Reply-To: <20201106103108.GB25324@yuki.lan>
References: <20201103161052.13260-1-chrubis@suse.cz>
 <20201103161052.13260-3-chrubis@suse.cz>
 <CAEemH2dUmmFx8cEhqMP6CLpRwszeBD=kMM4i3xpBKYSV+S2d8Q@mail.gmail.com>
 <20201106103108.GB25324@yuki.lan>
Message-ID: <CAEemH2d-qNTDMgehYo1OWzFTKp8TwxSDhj2kq0c2QYqMHomuJg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Nov 6, 2020 at 6:30 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > I tried with more complicated configurations for test parsing, most works
> > as expected but except the below one with parentheses ():
> >
> >     "CONFIG_DEFAULT_HOSTNAME=\"(none)\"",
> >
> > That's because the parentheses are the element of expression and used
> > to distinguish tokens, I???m not sure whether we can change it as a
> general
> > character to fix this problem, if no, we might need to comment on this in
> > the documentation.
>
> Well we would have to teach the tokenizer about strings, i.e. treat
> everything inside of double quotes as single token. That shouldn't be
> that hard, I can try to add this later on.
>

That would be great, thank you!

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201106/aaf5cc1a/attachment.htm>
