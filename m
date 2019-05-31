From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 May 2019 14:00:11 +0200
Subject: [LTP] [PATCH] syscalls/copy_file_range02.c: Compatible with new
 and old kernels
In-Reply-To: <CAEemH2eU+xcrDuW5UV=VCWhmHqrtOTE3HV=1Dr8cU8FWsBfLnw@mail.gmail.com>
References: <1559292243-2882-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <20190531110122.GA8819@rei.lan>
 <CAEemH2eU+xcrDuW5UV=VCWhmHqrtOTE3HV=1Dr8cU8FWsBfLnw@mail.gmail.com>
Message-ID: <20190531120011.GB8819@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This is a good suggestion. Another point I can come up is, if an LTS Linux
> distribution backports that commit 11cbfb10775a to their old kernel as
> regression fix, then this flag will make no sense.

Well that's life, there is no way how to detect if patch was backported
or not, so either we make the test pass on both EISDIR and EBADFD on
older kernels or we leave it as it is. Neither of the solutions is
perfect.

> So, to strict we maybe need to regards the EISDIR as the only one legal
> errno(copying content to dir) when  kernel >= 4.10(includes commit
> 11cbfb10775a).

Yes, exactly.

-- 
Cyril Hrubis
chrubis@suse.cz
