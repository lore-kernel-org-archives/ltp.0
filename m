From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Nov 2018 15:16:20 +0100
Subject: [LTP] [PATCH v2] fanotify09: check merging of events on child
	subdir
In-Reply-To: <20181109111520.27473-1-amir73il@gmail.com>
References: <20181109111520.27473-1-amir73il@gmail.com>
Message-ID: <20181120141620.GA10799@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've changed the __u32 into uint32_t which is the type we are supposed
to use in userspace and pushed, thanks!

-- 
Cyril Hrubis
chrubis@suse.cz
