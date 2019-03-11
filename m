From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 11 Mar 2019 17:00:16 +0100
Subject: [LTP] [PATCH] setpriority01: Skip only PRIO_USER when unable to
 add test user
In-Reply-To: <CAGETcx-07fGeAxXzD6Lo79XG-0OXJS8wzHztw4_72m2rO9Hpcw@mail.gmail.com>
References: <20190306215859.66044-1-saravanak@google.com>
 <20190307105933.GA1040@rei.lan>
 <CAGETcx-07fGeAxXzD6Lo79XG-0OXJS8wzHztw4_72m2rO9Hpcw@mail.gmail.com>
Message-ID: <20190311160016.GA14497@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> But is the test that's broken if useradd fails for wherever reason? Isn't
> it a configuration issue?

TBROK means "Test broken in preparation phase", while TCONF means "test
not applicable". Generally we use TCONF for missing functionality. If
useradd binary is present and fails to add a user for unknown reason
it's more likely failure in setting up the test environment than missing
functionality.

-- 
Cyril Hrubis
chrubis@suse.cz
