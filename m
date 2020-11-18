From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Nov 2020 14:58:52 +0100
Subject: [LTP] [PATCH] syscalls/getdents: don't mix libc and kernel types
In-Reply-To: <OFFFCF0315.CB01D2B7-ONC125861F.003C7A03-C1258622.0045EF86@avm.de>
References: <OFFFCF0315.CB01D2B7-ONC125861F.003C7A03-C1258622.0045EF86@avm.de>
Message-ID: <20201118135852.GA13912@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
First of all it would be easier to convert these testcases to the new
test library first since aparat from other things the new library has
support for test variants so that we can run one test for different
syscall wrappers.

Have a look for example at syscalls/stime/ how this could be
implemented.

-- 
Cyril Hrubis
chrubis@suse.cz
