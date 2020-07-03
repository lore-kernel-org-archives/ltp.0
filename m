From: Li Wang <liwang@redhat.com>
Date: Fri, 3 Jul 2020 09:20:56 +0800
Subject: [LTP] [PATCH v2 2/2] Add test for CVE 2017-1000405
In-Reply-To: <d0bd1421-500a-bc84-bd0a-7b5f25ade684@suse.cz>
References: <20200701151456.851-1-mdoucha@suse.cz>
 <20200701151456.851-2-mdoucha@suse.cz>
 <CAEemH2f2D9xBYxeQ33w0thxZFpkSHK3gn1bBQWMZSA=X5y-AWQ@mail.gmail.com>
 <d0bd1421-500a-bc84-bd0a-7b5f25ade684@suse.cz>
Message-ID: <CAEemH2eCD8vMH38guqwiPR64qePVYkCR0EkUsvDZXP3Vs_1OfQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 2, 2020 at 8:15 PM Martin Doucha <mdoucha@suse.cz> wrote:

> On 02. 07. 20 11:48, Li Wang wrote:
> >
> > Martin Doucha <mdoucha@suse.cz <mailto:mdoucha@suse.cz>> wrote:
> >
> >     ...
> >     +static void *alloc_zero_page(void *baseaddr)
> >     +{
> >     +       int i;
> >     +       void *ret;
> >     +
> >     +       /* Find aligned chunk of address space. MAP_HUGETLB doesn't
> >     work. */
> >     +       for (i = 0; i < 16; i++, baseaddr += thp_size) {
> >     +               ret = mmap(baseaddr, thp_size, PROT_READ,
> >     +                       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> >
> >
> > I'm wondering why here request the READ ONLY memory, shouldn't we write
> > something into the write_thp loopingly then?
>
> We do write into it. Except we do it through /proc/self/mem file
> descriptor. I didn't try with PROT_WRITE but presume that mapping the
> memory as read-only is important for confusing the kernel into thinking
> that the address space doesn't need to be copied on write.
>
> Nevertheless, I've tested the reproducer on a vulnerable kernel and it
> works reliably.
>

Thanks for the explanation, I helped merge the patchset v3.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200703/a1f14e85/attachment-0001.htm>
