From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Nov 2018 17:33:05 +0100
Subject: [LTP] [PATCH 2/2] syscalls/chmod05: Use new ltp library
In-Reply-To: <20181106161446.GF259383@sspatil-workstation.mtv.corp.google.com>
References: <20181106161126.251484-1-sspatil@google.com>
 <20181106161126.251484-3-sspatil@google.com>
 <20181106161446.GF259383@sspatil-workstation.mtv.corp.google.com>
Message-ID: <20181106163304.GH3014@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This was added, but I don't think it hurts anything, if at all it resets what
> the test does in the setup (even though its probably not needed)?. I'll leave
> it upto you to keep / delete this.

I've removed the cleanup and did a few minor changes as well and pushed,
thanks.

* Deleted /* stat struct */ and other comments commenting obvious

* Added return; in the if (TST_RET == -1) statement, there is no point
  in checking the directory permissions if the call has failed

* Removed spaces before tabs in the tst_test structure


-- 
Cyril Hrubis
chrubis@suse.cz
