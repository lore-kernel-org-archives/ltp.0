From: Steve Ellcey <sellcey@cavium.com>
Date: Wed, 22 Mar 2017 15:58:34 -0700
Subject: [LTP] time taken by memcg_stress_test
Message-ID: <201703222258.v2MMwYJR030273@sellcey-dt.caveonetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I have a question about memcg_stress_test.  Looking at memcg_stress_test.sh
I see that RUN_TIME is set to 3600 (60*60) which means that run_stress runs
for an hour.  And this is run twice, once in testcase_1 and once in
testcase_2.  That is a long time for one test, do we really think it needs
to run that long for 'proper' testing?  I would love to see this cut in
half or even down to 15 minutes.  I know I can just change the script locally,
but I was wondering if makes sense to change the default value.

Steve Ellcey
sellcey@cavium.com
