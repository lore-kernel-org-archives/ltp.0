From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 19 Nov 2019 15:24:44 +0100
Subject: [LTP] [PATCH] tst_fill_fs: enhance the filesystem filling
 routine
In-Reply-To: <CAEemH2cN8qv_YpsFKJazcOKEvgfjXpacZOV_Er-0bjK86=6VpQ@mail.gmail.com>
References: <20191119094156.20348-1-liwang@redhat.com>
 <1860355560.12961927.1574161647388.JavaMail.zimbra@redhat.com>
 <CAEemH2cN8qv_YpsFKJazcOKEvgfjXpacZOV_Er-0bjK86=6VpQ@mail.gmail.com>
Message-ID: <c9d278e6-5700-6c16-019b-1770a6ede0ff@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/19/19 3:03 PM, Li Wang wrote:
> On Tue, Nov 19, 2019 at 7:07 PM Jan Stancek <jstancek@redhat.com
> <mailto:jstancek@redhat.com>> wrote:
> 
>     ----- Original Message -----
>     > -? ? ? ? ? ? ?while (len) {
>     > +? ? ? ? ? ? ?while (len >= fi.f_bsize) {
> 
>     Let's say f_bsize is 512, and len is 1023. We hit ENOSPC for 1023,
>     len for next round is 511. Loop ends, but we never tried write with
>     f_bsize or smaller value.
> 
>     I think we should try len < fi.f_bsize@least once.
> 
> 
> Good point. At least for len = fi.f_bsize.

You don't need to reduce the write size in the first place. Kernel will
happily do short writes for you if the file system somehow finds some
free blocks. The more important question is how to trigger garbage
collection of internal file system book-keeping data.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
