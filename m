From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Mar 2017 12:44:24 +0100
Subject: [LTP] [PATCH v2 4/6] Added fallocate() flags and wrapper to lapi
In-Reply-To: <1488822340-29259-5-git-send-email-jracek@redhat.com>
References: <1488822340-29259-1-git-send-email-jracek@redhat.com>
 <1488822340-29259-5-git-send-email-jracek@redhat.com>
Message-ID: <20170307114424.GB1261@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This patch should also remove the original file
(testcases/kernel/syscalls/fallocate/fallocate.h) and fix the fallocate
testcases to include the header in lapi/.

-- 
Cyril Hrubis
chrubis@suse.cz
