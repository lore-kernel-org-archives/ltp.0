From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 9 May 2017 14:09:35 +0200
Subject: [LTP] TWARN and "ltp-pan reported PASS"
Message-ID: <20170509120935.q2v6dqhwmecy265w@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

our shell scripts wrapping ltp-pan binary report failure when there is any TWARN.

Similar code in these scripts:
runltp
runltplite.sh
testscripts/diskio.sh
testscripts/network.sh
testscripts/runEALtests.sh

if [ $? -eq "0" ]; then
  echo ltp-pan reported PASS
else
  echo ltp-pan reported FAIL
fi

Does using TWARN always always mean failure? I mean, it's good that ltp-pan returns 4
instead of 0, but wrapper script should return something like:

if [ $? -eq 0 ]; then
  echo ltp-pan reported PASS
elif [ $? -eq 4 ]; then
  echo ltp-pan reported PASS with warnings
else
  echo ltp-pan reported FAIL
fi


Kind regards,
Petr
