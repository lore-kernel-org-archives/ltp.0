From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 26 Feb 2020 15:02:32 +0100
Subject: [LTP] category of Running test
In-Reply-To: <MAXPR0101MB1468E9B371F52AD1B044DDFCEEEA0@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
References: <MAXPR0101MB1468E9B371F52AD1B044DDFCEEEA0@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <20200226140232.GE24080@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> i am running ltp on my machine and getting log in /opt/ltp with testcase and its status,is there any way to get result with 3 parameters testcase status and group?
> if yes how to run so and if no where should i make changes in existing ltp??

There is no such thing as a test group and there is no 1:1 mapping
between tests and runtest files. Some tests are in multiple runtest
files to begin with.

-- 
Cyril Hrubis
chrubis@suse.cz
