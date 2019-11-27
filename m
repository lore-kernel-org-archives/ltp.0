From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 27 Nov 2019 15:29:05 +0100
Subject: [LTP] [PATCH] tst_fill_fs: enhance the filesystem filling
 routine
In-Reply-To: <d76d2ad2-f302-3cd5-0c9f-5d96a6a4bd55@suse.cz>
References: <20191119094156.20348-1-liwang@redhat.com>
 <1860355560.12961927.1574161647388.JavaMail.zimbra@redhat.com>
 <CAEemH2cN8qv_YpsFKJazcOKEvgfjXpacZOV_Er-0bjK86=6VpQ@mail.gmail.com>
 <c9d278e6-5700-6c16-019b-1770a6ede0ff@suse.cz>
 <CAEemH2dZCm5MVyhzWiFKVK-jt+UUw65u5CRFk-moUVUgpDHHWg@mail.gmail.com>
 <d76d2ad2-f302-3cd5-0c9f-5d96a6a4bd55@suse.cz>
Message-ID: <986ec24a-0318-8217-52eb-816bbec5fb75@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,
here's something fun which I've discovered while playing with
fallocate05 test on XFS:
- fallocate(x blocks)
- tst_fill_fs()
- write(x blocks) - OK
- write(1 block) - ENOSPC
- fallocate(1 block) - OK
- write(1 block) - OK
- fallocate(1 block) - ENOSPC

Somehow, fallocate() can find another free block on XFS which wasn't
available to write() at first. But then that block becomes write()able.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
