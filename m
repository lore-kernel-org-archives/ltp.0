From: Li Wang <liwang@redhat.com>
Date: Thu, 2 Jul 2020 17:48:23 +0800
Subject: [LTP] [PATCH v2 2/2] Add test for CVE 2017-1000405
In-Reply-To: <20200701151456.851-2-mdoucha@suse.cz>
References: <20200701151456.851-1-mdoucha@suse.cz>
 <20200701151456.851-2-mdoucha@suse.cz>
Message-ID: <CAEemH2f2D9xBYxeQ33w0thxZFpkSHK3gn1bBQWMZSA=X5y-AWQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Martin Doucha <mdoucha@suse.cz> wrote:

...
> +static void *alloc_zero_page(void *baseaddr)
> +{
> +       int i;
> +       void *ret;
> +
> +       /* Find aligned chunk of address space. MAP_HUGETLB doesn't work.
> */
> +       for (i = 0; i < 16; i++, baseaddr += thp_size) {
> +               ret = mmap(baseaddr, thp_size, PROT_READ,
> +                       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>

I'm wondering why here request the READ ONLY memory, shouldn't we write
something into the write_thp loopingly then?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200702/373aa7d0/attachment.htm>
