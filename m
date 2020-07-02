From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 2 Jul 2020 14:09:10 +0200
Subject: [LTP] [PATCH v2 2/2] Add test for CVE 2017-1000405
In-Reply-To: <CAEemH2f2D9xBYxeQ33w0thxZFpkSHK3gn1bBQWMZSA=X5y-AWQ@mail.gmail.com>
References: <20200701151456.851-1-mdoucha@suse.cz>
 <20200701151456.851-2-mdoucha@suse.cz>
 <CAEemH2f2D9xBYxeQ33w0thxZFpkSHK3gn1bBQWMZSA=X5y-AWQ@mail.gmail.com>
Message-ID: <d0bd1421-500a-bc84-bd0a-7b5f25ade684@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02. 07. 20 11:48, Li Wang wrote:
> 
> Martin Doucha <mdoucha@suse.cz <mailto:mdoucha@suse.cz>> wrote:
> 
>     ...
>     +static void *alloc_zero_page(void *baseaddr)
>     +{
>     +? ? ? ?int i;
>     +? ? ? ?void *ret;
>     +
>     +? ? ? ?/* Find aligned chunk of address space. MAP_HUGETLB doesn't
>     work. */
>     +? ? ? ?for (i = 0; i < 16; i++, baseaddr += thp_size) {
>     +? ? ? ? ? ? ? ?ret = mmap(baseaddr, thp_size, PROT_READ,
>     +? ? ? ? ? ? ? ? ? ? ? ?MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> 
> 
> I'm wondering why here request the READ ONLY memory, shouldn't we write
> something into the write_thp loopingly then?

We do write into it. Except we do it through /proc/self/mem file
descriptor. I didn't try with PROT_WRITE but presume that mapping the
memory as read-only is important for confusing the kernel into thinking
that the address space doesn't need to be copied on write.

Nevertheless, I've tested the reproducer on a vulnerable kernel and it
works reliably.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
