Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <prvs=4195c8093f=G.Rajender@lnties.com>)
	id 1QoF0V-0008Bf-CH
	for ltp-list@lists.sourceforge.net; Tue, 02 Aug 2011 13:27:39 +0000
Received: from mailout2.ltindia.com ([125.18.18.171])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QoF0S-00037g-Pb
	for ltp-list@lists.sourceforge.net; Tue, 02 Aug 2011 13:27:39 +0000
From: G Rajender <G.Rajender@lnties.com>
Date: Tue, 2 Aug 2011 13:27:26 +0000
Message-ID: <260174ADA4D63F4AA543B9C81F2DE712B87B@POCITMSEXMB01.LntUniverse.com>
References: <260174ADA4D63F4AA543B9C81F2DE712B34F@POCITMSEXMB01.LntUniverse.com>
	<CAMhs6YzX0srwbYm778ro7o7zLGKZfmpqrRaPUgBTzX+a4arRCQ@mail.gmail.com>
	<260174ADA4D63F4AA543B9C81F2DE712B601@POCITMSEXMB01.LntUniverse.com>
	<CAMhs6Yy76dinKx_SSXfB90+76g3iUL6okPUNgETDMiVHpCrsgw@mail.gmail.com>
	<260174ADA4D63F4AA543B9C81F2DE712B6A2@POCITMSEXMB01.LntUniverse.com>
	<260174ADA4D63F4AA543B9C81F2DE712B7AB@POCITMSEXMB01.LntUniverse.com>,
	<CAMhs6Yy17=HN_zc_4yC=1_GYLjisVq6UUR5UU0Kna_Syas154w@mail.gmail.com>
In-Reply-To: <CAMhs6Yy17=HN_zc_4yC=1_GYLjisVq6UUR5UU0Kna_Syas154w@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] How to test Linux Kernel using LTP on Beagleboard (ARM
 Cortex-A8 based board)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Maxin B John <maxin.john@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi Maxin,

Thank you very much for your reply. I have done all the steps that you've mentioned and created LTP-Cross compiled binary images for beagleboard.

I have copied the LTP binaries along with required boot-able &kernel (2.6.32) images on to the SD card formating with FAT32 file system. Booted the beagleboard  and got the command prompt as below and tries to execute "runalltests.sh" in command prompt. I'm getting the below errors.

"root@beagleboard: ./runalltests.sh "

Running tests.......
[24280.369506] warning: process `bdflush01' used the obsolete bdflush system call
[24280.380249] Fix your initscripts?
.......................................................

Generating HTML Output.....!!
INFO: creating /media/mmcblk0p1/results directory
./runltp: line 954: perl: not found
Generated HTML Output.....!!
Location: /media/mmcblk0p1/output/2010_Aug_21-18h_46m_44s.html

       ###############################################################"

            Done executing testcases."
            LTP Version:  LTP-20100228
       ###############################################################"

Generating HTML Output.....!!
./runltp: line 954: perl: not found
Generated HTML Output.....!!
Location: /media/mmcblk0p1/output/2010_Aug_21-18h_46m_44s.html

       ###############################################################"

            Done executing testcases."
            LTP Version:  LTP-20100228
       ###############################################################"

Generating HTML Output.....!!
./runltp: line 954: perl: not found
Generated HTML Output.....!!
Location: /media/mmcblk0p1/output/2010_Aug_21-18h_46m_44s.html
...................

???root@beagleboard:/media/mmcblk0p1# ./runalltests.sh: line 380: syntax error: unterminated quoted string
./runltp: line 955: ?: not found
*** glibc detected *** /bin/sh: free(): invalid pointer: 0x000a0b00 ***
./runalltests.sh: line 380: syntax error: unterminated quoted string


Can you please suggest me on how to solve the above errors to run command "runalltests.sh" and "runltp.sh" scripts.

There are some of individual testscripts. If i am trying to execute with below command a

root@beagleboard:/media/mmcblk0p1/testscripts# ./diskio.sh
........................
incrementing stop
ERROR [line: open failed: No such file or directory
]
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=255 corefile=no
cutime=0 cstime=0
<<<test_end>>>
ltp-pan reported FAIL

Can you please suggest me how to solve the above errors to run all the individual test scripts like "diskio.sh" etc......
Thanks in advance for your time and support.

Best Reagrds,
Rajender

________________________________________
From: Maxin B John [maxin.john@gmail.com]
Sent: Monday, August 01, 2011 7:34 PM
To: G Rajender
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] How to test Linux Kernel using LTP on Beagleboard (ARM Cortex-A8 based board)

Hi Rajender,

On Mon, Aug 1, 2011 at 4:13 PM, G Rajender <G.Rajender@lnties.com> wrote:
>
> I have successfully installed Scratchbox1 and selected the armv7 target in sub-menu. I got shell prompt like "[ sbox- armv7  ~]". I have downloaded the LTP source "ltp-full-20100228.ar.gz" from LTP-web.
>
> Can you please share the procedure of how to Cross-Compile the LTP source code using Scratchbox1 to generate the binaries for the beagleboard.
>

The Scratchbox environment simplifies the cross-compilation process.
Within the Scratchbox environment, perform the following steps:

# tar zxvf ltp-full-20100228.tar.gz
# cd ltp-full-20100228
# ./configure
# make
# make install

You will find the cross-compiled binaries in "/opt/ltp" directory in
Scratchbox. Move these binaries to your Beagleboard to execute LTP
test-suite on the target board.

Hope this helps.
Maxin B. John


Larsen & Toubro Limited

www.larsentoubro.com

This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

------------------------------------------------------------------------------
BlackBerry&reg; DevCon Americas, Oct. 18-20, San Francisco, CA
The must-attend event for mobile developers. Connect with experts. 
Get tools for creating Super Apps. See the latest technologies.
Sessions, hands-on labs, demos & much more. Register early & save!
http://p.sf.net/sfu/rim-blackberry-1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
