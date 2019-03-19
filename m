From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Mar 2019 11:06:33 +0100
Subject: [LTP] [PATCH] setpriority01: Skip only PRIO_USER when unable to
 add test user
In-Reply-To: <CAGETcx9h4AooQxU4v7apAp4x+q_6xYYSaSFpEfSeBXHymqfN6Q@mail.gmail.com>
References: <20190306215859.66044-1-saravanak@google.com>
 <20190307105933.GA1040@rei.lan>
 <CAGETcx-07fGeAxXzD6Lo79XG-0OXJS8wzHztw4_72m2rO9Hpcw@mail.gmail.com>
 <CAGETcx-yRfA+zmRScronhaVe6auMkzso6cHeDFtOaXzkE99Hwg@mail.gmail.com>
 <20190311160441.GB14497@rei.lan>
 <CAGETcx-MnmCmjGDubaLfauQ0Rf6dayS8ykB7MbdL+U1_ajpTuw@mail.gmail.com>
 <CAGETcx9h4AooQxU4v7apAp4x+q_6xYYSaSFpEfSeBXHymqfN6Q@mail.gmail.com>
Message-ID: <20190319100633.GC6204@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Sorry for late reply, looking into useradd manual mapping return value 1
to TCONF should do the job here.

-- 
Cyril Hrubis
chrubis@suse.cz
