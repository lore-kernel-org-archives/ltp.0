From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 May 2016 19:28:50 +0200
Subject: [LTP] [PATCH 4/6] syscalls/madvise04: Convert to new test API
In-Reply-To: <1463042993-398-4-git-send-email-liwang@redhat.com>
References: <1463042993-398-1-git-send-email-liwang@redhat.com>
 <1463042993-398-2-git-send-email-liwang@redhat.com>
 <1463042993-398-3-git-send-email-liwang@redhat.com>
 <1463042993-398-4-git-send-email-liwang@redhat.com>
Message-ID: <20160517172850.GD13705@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
The MADV_DONTDUMP and MADV_DODUMP could be easily moved into madvise01.

-- 
Cyril Hrubis
chrubis@suse.cz
