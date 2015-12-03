From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Dec 2015 14:16:34 +0100
Subject: [LTP] [PATCH V6] controllers/pids: Add new testcases
In-Reply-To: <1448537493-18755-1-git-send-email-chnyda@suse.com>
References: <1448537493-18755-1-git-send-email-chnyda@suse.com>
Message-ID: <20151203131634.GD29110@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with following change:

 case3()
  {
  -       tmp=$((max + 1))
  -       tst_resm TINFO "limit the number of avalaible pid to $tmp"
  -       ROD echo $tmp > $testpath/pids.max
  +       tst_resm TINFO "limit the number of avalaible pid to $max"
  +       ROD echo $max > $testpath/pids.max

Since we start max-2 processes there is no need to set the limit to
max+1.

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
