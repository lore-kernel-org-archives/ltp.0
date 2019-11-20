From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 20 Nov 2019 10:07:15 +0100
Subject: [LTP] [PATCH] tst_fill_fs: enhance the filesystem filling
 routine
In-Reply-To: <CAEemH2dZCm5MVyhzWiFKVK-jt+UUw65u5CRFk-moUVUgpDHHWg@mail.gmail.com>
References: <20191119094156.20348-1-liwang@redhat.com>
 <1860355560.12961927.1574161647388.JavaMail.zimbra@redhat.com>
 <CAEemH2cN8qv_YpsFKJazcOKEvgfjXpacZOV_Er-0bjK86=6VpQ@mail.gmail.com>
 <c9d278e6-5700-6c16-019b-1770a6ede0ff@suse.cz>
 <CAEemH2dZCm5MVyhzWiFKVK-jt+UUw65u5CRFk-moUVUgpDHHWg@mail.gmail.com>
Message-ID: <d76d2ad2-f302-3cd5-0c9f-5d96a6a4bd55@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/20/19 3:19 AM, Li Wang wrote:
>     You don't need to reduce the write size in the first place. Kernel will
>     happily do short writes for you if the file system somehow finds some
> 
> 
> You're probably right, but here I just want to enhance the tst_fill_fs
> routine, it obviously couldn't? be guaranteed way to perfectly fill a
> filesystem, this action from userspace is what I can think of.

I was also talking about enhancing tst_fill_fs(). You can simply repeat
write()s with the maximum size until you're sure the file system is
really full. Reducing the write size and then also using the write size
as iteration counter creates some really nasty edge cases that can be
easily avoided.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
