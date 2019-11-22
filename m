From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 22 Nov 2019 10:35:02 +0100
Subject: [LTP] test metadata update
Message-ID: <20191122093501.GA19146@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've had a bit of time to continue working on the test metadata.

I've added a testsuite description to the json file, wrote very simple
javascript based render for the file and added a json schema. It's not
100% finished yet, but it shows some nice progress. For one thing the
file the test parsing produces is not yet fully conformant to the
schema, but I'm getting close. Also the schema is very basic at this
point, we will add more things along the way.

You can see how the test catalog looks at:
http://metan.ucw.cz/outgoing/metadata.html

The rest of the work is at usuall place in my git repo at:
https://github.com/metan-ucw/ltp/tree/master/docparse

Also as per usuall any feedback is welcome.

-- 
Cyril Hrubis
chrubis@suse.cz
