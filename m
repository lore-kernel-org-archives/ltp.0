From: Li Wang <liwang@redhat.com>
Date: Tue, 17 Mar 2020 17:27:07 +0800
Subject: [LTP] [RFC] Define minimal supported kernel and (g)libc version
In-Reply-To: <20200317090412.GA31467@dell5510>
References: <20200313141458.GB21248@dell5510>
 <CAEemH2cNc7pCc-wB=4hGVquJT1Y5NCeZ_z8nH6D9V+J_5o_TWw@mail.gmail.com>
 <20200317081547.GA15989@dell5510>
 <CAEemH2dCckuUw=x-yKpBe4FpjTdovytSqpOoRSTFiR96_ECeDA@mail.gmail.com>
 <20200317090412.GA31467@dell5510>
Message-ID: <CAEemH2dxrEdFxaro_e3roe=VUs6_mbnSLdfV4kz4OA09hiw08Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Tue, Mar 17, 2020 at 5:04 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> > > The oldest system in travis we have CentOS 6: kernel-2.6.32 /
> glibc-2.12 /
> > > gcc-4.4.7 (clang-3.4.2, but we don't test it with clang). I'm ok to
> have
> > > this
> > > older dependency, just to make sure it builds.  But code would be
> cleaner
> > > for
> > > sure if we drop it.
>
> > +1
> > Sounds good to me.
> I'm sorry, are you for removing CentOS 6 from Travis or not?
>

I previously think these words mean that only make sure LTP build passes on
CentOS6(but not remove it).

But removing is also Ok to me, we can do that after we reaching an
agreement on the supporting package-version and write it down in Docs. That
probably occurring in the next release if everything goes well:).

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200317/ecf3daff/attachment.htm>
