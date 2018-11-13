From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Nov 2018 13:49:44 +0100
Subject: [LTP] [PATCH 2/2] syscalls/sighold02: ignore reserved signals
In-Reply-To: <20181109014616.165281-2-smuckle@google.com>
References: <20181109014616.165281-1-smuckle@google.com>
 <20181109014616.165281-2-smuckle@google.com>
Message-ID: <20181113124943.GA11121@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Some signals may be internally used by the C library. Do not attempt to
> verify these.

This is a nice cleanup, applied, thanks.

> Change-Id: If5a6a9bd7bbeceacde6904393c7452d927fa7522

I've removed this tag and added your Signed-off-by here.

-- 
Cyril Hrubis
chrubis@suse.cz
