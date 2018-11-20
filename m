From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Nov 2018 17:42:49 +0100
Subject: [LTP] [PATCH v3 2/6] syscalls/readahead02: Convert to newlib
 and cleanup
In-Reply-To: <20181120160751.GA18182@rei.lan>
References: <20181010233441.5337-1-amir73il@gmail.com>
 <20181010233441.5337-3-amir73il@gmail.com>
 <20181120160751.GA18182@rei.lan>
Message-ID: <20181120164249.GA19952@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >  #if defined(__NR_readahead)

Also we do have fallback definitions in lapi/syscalls.h, so
__NR_readahead is never undefined, we can safely drop this ifdef.

-- 
Cyril Hrubis
chrubis@suse.cz
