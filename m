From: Hoang Thi Thuy Nga (RBVH/ENG2) <Nga.HoangThiThuy@vn.bosch.com>
Date: Wed, 13 Jul 2016 04:35:29 +0000
Subject: [LTP] updating message_queue_test_02_*
In-Reply-To: <57835D54.2020803@de.bosch.com>
References: <577E4340.4060208@de.bosch.com> <577E535F.2040606@de.bosch.com>
 <c5da00d5b67d484d9c8b23ede1b3746f@SGPMBX1022.APAC.bosch.com>
 <f63310d9c63440bbb1c3372a459d3582@FE-MBX1024.de.bosch.com>
 <ce7e60e37813403a98b3594aec354d06@SGPMBX1022.APAC.bosch.com>,
 <57835D54.2020803@de.bosch.com>
Message-ID: <1468384528972.33794@vn.bosch.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Oleksij and all, 

Attachment is the patch file for adding message_queue_test_02.sh
Please help me check 

Regards,
Nga Hoang
 _____________________________________________
> *From:* FIXED-TERM Rempel Oleksij (CM/ESO3)
> *Sent:* Friday, July 08, 2016 5:57 PM
> *To:* Hoang Thi Thuy Nga (RBVH/ENG2) <Nga.HoangThiThuy@vn.bosch.com>;
> ltp@lists.linux.it; Le Cong Binh (RBVH/ENG2) <Binh.LeCong@vn.bosch.com>
> *Cc:* Tran Thanh Lam (RBVH/ENG2) <Lam.TranThanh2@vn.bosch.com>; Cyril
> Hrubis <chrubis@suse.cz>
> *Subject:* RE: [LTP] updating message_queue_test_02_*
>
>
> Hi  Nga,
>
> thank you.
> Since this tests depend on each other, it makes sense to merge them to one.
> For example create:
> ./testcases/bin/message_queue_test_02.sh
>
> And use message_queue_test_02.sh instead of message_queue_test_02_* in
> the test list.
> This will still not fix the issue with custom tmp folder, but will not
> block testing on reset or random test execution.
>
> LTP devs, any objections here?
> If no, Nga, can you please provide a patch for it?
>
>
> _____________________________________________
> *From:* Hoang Thi Thuy Nga (RBVH/ENG2)
> *Sent:* Friday, July 08, 2016 11:25 AM
> *To:* FIXED-TERM Rempel Oleksij (CM/ESO3)
> <_fixed-term.Oleksij.Rempel@de.bosch.com_
> <mailto:fixed-term.Oleksij.Rempel@de.bosch.com>>; _ltp@lists.linux.it_
> <mailto:ltp@lists.linux.it>; Le Cong Binh (RBVH/ENG2)
> <_Binh.LeCong@vn.bosch.com_ <mailto:Binh.LeCong@vn.bosch.com>>
> *Cc:* Tran Thanh Lam (RBVH/ENG2) <_Lam.TranThanh2@vn.bosch.com_
> <mailto:Lam.TranThanh2@vn.bosch.com>>
> *Subject:* RE: [LTP] updating message_queue_test_02_*
>
>
> Hi Oleksij,
>
> Some observations from our side:
>
>   * In other to run *message_queue_test_02_snd*,
>     *message_queue_test_02_rcv*, *message_queue_test_02_ctl*
>     successfully, we need to run *message_queue_test_02_get***before.
>
> Because *message_queue_test_02_get***will create file
> */tmp/message_queue_test *as well as**create *generate message queue
> identifier* which will be used in the other three.
>
>   * *message_queue_test_02_snd*, *message_queue_test_02_rcv*,
>     *message_queue_test_02_ctl* doesn’t work with –f to specify another
>     location for project name *in case* the message queue identifier not
>     yet generated along with the file
>
>
> *message_queue_test_02_get.c*
>
>         *int**main*(*int*argc, *char***argv),
> {
>         _key_t_key;              /* Unique key */
>         *int*msqid;              /* Message queue identifier */
>         *int*fd;                 /* _Temp_file descriptor */
>         _mode_t_mode = 0777;     /* Default mode bits */
>
>         /*
>         * Parse command line options
>         */
>         parse_args(argc, argv);
>
>         *i**f**((fd = open(**project_name**, **_O_CREAT_**|
> **_O_RDWR_**, mode)) < 0)*
>                 *sys_error("open failed", __LINE__);*
>
>         *if*(close(fd) < 0)
>                 sys_error("close failed", __LINE__);
>
>         *if*((key = ftok(project_name, project_id)) < 0)
>                 sys_error("_ftok_failed", __LINE__);
>
>         *if**((msqid = msgget(key, **_IPC_CREAT_**| **_S_IRUSR_**|
> **_S_IWUSR_**)) < 0)*
>                 *sys_error("**_msgget_**failed", __LINE__);*
>
>         printf("%d\n", msqid);
>
>         *return*(0);
> }
>
>
> Trân trọng / Best regards
>
> Nga Hoang Thi Thuy
> RBVH/ENG2
>
> Tel. +49(711)8113624527
>
>
>
> -----Original Message-----
> From: FIXED-TERM Rempel Oleksij (CM/ESO3)
> Sent: Thursday, July 07, 2016 8:05 PM
> To: _ltp@lists.linux.it_ <mailto:ltp@lists.linux.it>; Le Cong Binh
> (RBVH/ENG2) <_Binh.LeCong@vn.bosch.com_
> <mailto:Binh.LeCong@vn.bosch.com>>; Hoang Thi Thuy Nga (RBVH/ENG2)
> <_Nga.HoangThiThuy@vn.bosch.com_ <mailto:Nga.HoangThiThuy@vn.bosch.com>>
> Subject: Re: [LTP] updating message_queue_test_02_*
>
> On 07.07.2016 13:55, fixed-term.Oleksij.Rempel wrote:
>> Hallo all,
>>
>> it is kind of a duplication of this case:
>> https://github.com/linux-test-project/ltp/issues/75
>>
>> some of message_queue_test_02_* are fail on our configuration, it looks
>> like the reason is hardcoded tmp path, which is different in our test setup.
>>
>> Looks like this tests should be updated to use current ltp bindings..
>> which should also fix this issue.  Do any one already working on it? If
>> not, me or some of us will try to do it.
>>
>
> hm...
> to execute *message_queue_test_02_rcv* properly, first should be
> *message_queue_test_02_snd* executed. And most important, target should
> not be reseted after message_queue_test_02_snd. If this happens,
> message_queue_test_02_rcv will hang forever.
> It is not looks like proper behaviour (it is not theoretical assumption.).
>
> May be message_queue_test_02_rcv should be wrapped by a script which
> will start rcv in background and then send after short sleep?
> And some how make sure that message_queue_test_02_rcv wont wait forever?
>
> Any comments?
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch.diff
Type: text/x-patch
Size: 398 bytes
Desc: patch.diff
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160713/4a17e0be/attachment.bin>
