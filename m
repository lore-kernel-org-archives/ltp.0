From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Jan 2019 15:57:55 +0100
Subject: [LTP] [PATCH 1/3] getrlimit/getrlimit03: fix breakage with
 Aarch32
In-Reply-To: <20181227003102.246617-1-smuckle@google.com>
References: <20181227003102.246617-1-smuckle@google.com>
Message-ID: <20190103145755.GC16662@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
As Li pointed out there was patch from Ritchie trying to fix the same
issue. In the end I've taken your patch and added the TCONF message and
updated the commit message with info from the other patch.

And pushed with these modifications, thanks!

-- 
Cyril Hrubis
chrubis@suse.cz
