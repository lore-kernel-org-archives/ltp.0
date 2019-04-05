From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 5 Apr 2019 14:00:30 +0200
Subject: [LTP] [PATCH v2 1/2] syscalls/accept01: convert to new library.
In-Reply-To: <20190328114700.189583-1-sspatil@android.com>
References: <20190328114700.189583-1-sspatil@android.com>
Message-ID: <20190405120030.GA7540@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

* The TST_RET has to be printed with %li

* Closed also udp_fd in cleanup()

-- 
Cyril Hrubis
chrubis@suse.cz
