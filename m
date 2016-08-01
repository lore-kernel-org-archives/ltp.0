From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 1 Aug 2016 16:34:47 +0200
Subject: [LTP] [PATCH V3 23/23] shmem_test_04: Include sys/types.h for
 caddr_t
In-Reply-To: <20160722042656.22346-23-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-23-raj.khem@gmail.com>
Message-ID: <20160801143447.GC8568@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
The caddr_t is legacy BSD type it should rather be replaced with void *.

-- 
Cyril Hrubis
chrubis@suse.cz
