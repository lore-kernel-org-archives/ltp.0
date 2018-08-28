From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Aug 2018 15:35:08 +0200
Subject: [LTP] [PATCH ltp] syscalls/munlockall02: fix the outdated TCONF
 message
In-Reply-To: <20180828155253.30621-1-junchi.chen@intel.com>
References: <20180828155253.30621-1-junchi.chen@intel.com>
Message-ID: <20180828133508.GA26231@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Given that 2.6.11 is quite old, 13 years to be exact I would be in favor
for dropping this particular EPERM test completely.

-- 
Cyril Hrubis
chrubis@suse.cz
