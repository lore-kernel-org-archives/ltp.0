From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Jan 2020 14:32:07 +0100
Subject: [LTP] [PATCH v1 1/4] syscalls/capset01: Cleanup & convert to
 new library
In-Reply-To: <1576577571-3668-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1576577571-3668-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1576577571-3668-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200107133207.GD26408@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This test was missing the SPDX licence header, I've added it and pushed,
thanks.

Also we do not cover the pid == 0 case here either, that should be added
later on.

-- 
Cyril Hrubis
chrubis@suse.cz
