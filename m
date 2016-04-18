From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 18 Apr 2016 11:37:54 +0800
Subject: [LTP] [PATCH v2] inotify: Add test for inotify mark destruction
 race
In-Reply-To: <20160414084611.GC2753@quack2.suse.cz>
References: <1439215460-15670-1-git-send-email-jack@suse.com>
 <20150811141432.GA21861@rei.suse.de> <20150811142035.GD2659@quack.suse.cz>
 <20150825092925.GA19905@rei.suse.de> <20150825103803.GA15280@quack.suse.cz>
 <20150825112920.GB20082@rei.suse.de> <570EFB43.3020704@cn.fujitsu.com>
 <20160414081516.GA2753@quack2.suse.cz> <570F5161.7060806@cn.fujitsu.com>
 <20160414084611.GC2753@quack2.suse.cz>
Message-ID: <57145692.6070205@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

hello,

On 04/14/2016 04:46 PM, Jan Kara wrote:
> On Thu 14-04-16 16:14:25, Xiaoguang Wang wrote:
>> On 04/14/2016 04:15 PM, Jan Kara wrote:
>>> Hello,
>>>
>>> On Thu 14-04-16 10:06:59, Xiaoguang Wang wrote:
>>>> On 08/25/2015 07:29 PM, Cyril Hrubis wrote:
>>>>> Hi!
>>>>>> Interesting, probably SRCU is much slower with this older kernel. From my
>>>>>> experiments 100 iterations isn't quite reliable to trigger the oops in my
>>>>>> testing instance. But 400 seem to be good enough.
>>>>>
>>>>> I've changed the nuber of iterations to 400 and pushed it to git,
>>>>> thanks.
>>>>>
>>>>
>>>> In upstream kernel v4.6-rc3-17-g1c74a7f and RHEL7.2GA, I sometimes get such
>>>> error:
>>>> ---------------------------------------------------------------------------
>>>> inotify06    1  TBROK  :  inotify06.c:104: inotify_init failed: errno=EMFILE(24): Too many open files
>>>> inotify06    2  TBROK  :  inotify06.c:104: Remaining cases broken
>>>> ---------------------------------------------------------------------------
>>>> But look at the inotify06.c, inotify_fd is closed every iteration.
>>>> For normal file descriptors, "close(fd) succeeds" does not mean related kernel
>>>> resources have been released immediately(processes may still reference fd).
>>>>
>>>> Then inotify_fd  also has similar behavior? Even close(inotify_fd) returns,
>>>> that does not mean the number of current inotify instances have decreased one
>>>> immediately, then later inotify_init() calls may exceeds the /proc/sys/fs/inotify/max_user_instances and
>>>> return EMFILE error?  I had added some debug code in kernel, it seems that close(inotify_fd)
>>>> does not make sure current inotify instances decreases one immediately.
>>>>
>>>> So I'd like to know this is expected behavior for inotify? If yes, we can
>>>> echo 400 > /proc/sys/fs/inotify/max_user_instances to avoid EMFILE error.
>>>> If not, this is a kernel bug?
>>>
>>> Interesting, I've never seen this. Number of inotify instances is maintaned
>>> immediately - i.e., it is dropped as soon as the last descriptor pointing to
>>> the instance is closed. So I'm not sure how what you describe can happen.
>>> How do you reproduce the issue?
>> I just call ./inotify06 directly, and about 50% chance, it'll fail(return EMFILE).
> 
> Hum, I've just tried 4.6-rc1 which I have running on one test machine and
> it survives hundreds of inotify06 calls in a loop without issues. I have
> max_user_instances set to 128 on that machine... So I suspect the problem
> is somewhere in your exact userspace setup. Aren't there other processes
> using inotify heavily for that user?
I doubted so, but please see my debug results in my virtual machine, it still
seems that it's a kernel issue...
I add some simple debug code to kernel and ltp test case inotify06, and switched
to a normal user "lege" to have a test.

[lege@localhost inotify]$ uname -r
4.6.0-rc3+

From testcase_run.info, we can see that inotify_init1 has been called for 240 iterations(0-239),
and the 239th iteration failed(return EMFILE error), meanwhile from dmesg.info, we can also see
that kernel function inotify_new_group() was called for 240 iterations, and the last iteration
failed(exceed the 128 limits). From test results, I think when I ran inotify06, at least for the
period inotify06 ran, there is no other process calling inotify_init1(), so it's not likely a
userspace setup issue. Also from demes.info, you can see that every time inotify_new_group()
was called, group->inotify_data.user->inotify_devs is not always 0. so whether close(inotify_fd)
could not make number of inotify instances dropped as soon as the last descriptor pointing to
the instance is closed? Thanks.

Regards,
Xiaoguang Wang
> 
> 								Honza
> 



-------------- next part --------------
inotify_init1 called 0
inotify_init1 called 1
inotify_init1 called 2
inotify_init1 called 3
inotify_init1 called 4
inotify_init1 called 5
inotify_init1 called 6
inotify_init1 called 7
inotify_init1 called 8
inotify_init1 called 9
inotify_init1 called 10
inotify_init1 called 11
inotify_init1 called 12
inotify_init1 called 13
inotify_init1 called 14
inotify_init1 called 15
inotify_init1 called 16
inotify_init1 called 17
inotify_init1 called 18
inotify_init1 called 19
inotify_init1 called 20
inotify_init1 called 21
inotify_init1 called 22
inotify_init1 called 23
inotify_init1 called 24
inotify_init1 called 25
inotify_init1 called 26
inotify_init1 called 27
inotify_init1 called 28
inotify_init1 called 29
inotify_init1 called 30
inotify_init1 called 31
inotify_init1 called 32
inotify_init1 called 33
inotify_init1 called 34
inotify_init1 called 35
inotify_init1 called 36
inotify_init1 called 37
inotify_init1 called 38
inotify_init1 called 39
inotify_init1 called 40
inotify_init1 called 41
inotify_init1 called 42
inotify_init1 called 43
inotify_init1 called 44
inotify_init1 called 45
inotify_init1 called 46
inotify_init1 called 47
inotify_init1 called 48
inotify_init1 called 49
inotify_init1 called 50
inotify_init1 called 51
inotify_init1 called 52
inotify_init1 called 53
inotify_init1 called 54
inotify_init1 called 55
inotify_init1 called 56
inotify_init1 called 57
inotify_init1 called 58
inotify_init1 called 59
inotify_init1 called 60
inotify_init1 called 61
inotify_init1 called 62
inotify_init1 called 63
inotify_init1 called 64
inotify_init1 called 65
inotify_init1 called 66
inotify_init1 called 67
inotify_init1 called 68
inotify_init1 called 69
inotify_init1 called 70
inotify_init1 called 71
inotify_init1 called 72
inotify_init1 called 73
inotify_init1 called 74
inotify_init1 called 75
inotify_init1 called 76
inotify_init1 called 77
inotify_init1 called 78
inotify_init1 called 79
inotify_init1 called 80
inotify_init1 called 81
inotify_init1 called 82
inotify_init1 called 83
inotify_init1 called 84
inotify_init1 called 85
inotify_init1 called 86
inotify_init1 called 87
inotify_init1 called 88
inotify_init1 called 89
inotify_init1 called 90
inotify_init1 called 91
inotify_init1 called 92
inotify_init1 called 93
inotify_init1 called 94
inotify_init1 called 95
inotify_init1 called 96
inotify_init1 called 97
inotify_init1 called 98
inotify_init1 called 99
inotify_init1 called 100
inotify_init1 called 101
inotify_init1 called 102
inotify_init1 called 103
inotify_init1 called 104
inotify_init1 called 105
inotify_init1 called 106
inotify_init1 called 107
inotify_init1 called 108
inotify_init1 called 109
inotify_init1 called 110
inotify_init1 called 111
inotify_init1 called 112
inotify_init1 called 113
inotify_init1 called 114
inotify_init1 called 115
inotify_init1 called 116
inotify_init1 called 117
inotify_init1 called 118
inotify_init1 called 119
inotify_init1 called 120
inotify_init1 called 121
inotify_init1 called 122
inotify_init1 called 123
inotify_init1 called 124
inotify_init1 called 125
inotify_init1 called 126
inotify_init1 called 127
inotify_init1 called 128
inotify_init1 called 129
inotify_init1 called 130
inotify_init1 called 131
inotify_init1 called 132
inotify_init1 called 133
inotify_init1 called 134
inotify_init1 called 135
inotify_init1 called 136
inotify_init1 called 137
inotify_init1 called 138
inotify_init1 called 139
inotify_init1 called 140
inotify_init1 called 141
inotify_init1 called 142
inotify_init1 called 143
inotify_init1 called 144
inotify_init1 called 145
inotify_init1 called 146
inotify_init1 called 147
inotify_init1 called 148
inotify_init1 called 149
inotify_init1 called 150
inotify_init1 called 151
inotify_init1 called 152
inotify_init1 called 153
inotify_init1 called 154
inotify_init1 called 155
inotify_init1 called 156
inotify_init1 called 157
inotify_init1 called 158
inotify_init1 called 159
inotify_init1 called 160
inotify_init1 called 161
inotify_init1 called 162
inotify_init1 called 163
inotify_init1 called 164
inotify_init1 called 165
inotify_init1 called 166
inotify_init1 called 167
inotify_init1 called 168
inotify_init1 called 169
inotify_init1 called 170
inotify_init1 called 171
inotify_init1 called 172
inotify_init1 called 173
inotify_init1 called 174
inotify_init1 called 175
inotify_init1 called 176
inotify_init1 called 177
inotify_init1 called 178
inotify_init1 called 179
inotify_init1 called 180
inotify_init1 called 181
inotify_init1 called 182
inotify_init1 called 183
inotify_init1 called 184
inotify_init1 called 185
inotify_init1 called 186
inotify_init1 called 187
inotify_init1 called 188
inotify_init1 called 189
inotify_init1 called 190
inotify_init1 called 191
inotify_init1 called 192
inotify_init1 called 193
inotify_init1 called 194
inotify_init1 called 195
inotify_init1 called 196
inotify_init1 called 197
inotify_init1 called 198
inotify_init1 called 199
inotify_init1 called 200
inotify_init1 called 201
inotify_init1 called 202
inotify_init1 called 203
inotify_init1 called 204
inotify_init1 called 205
inotify_init1 called 206
inotify_init1 called 207
inotify_init1 called 208
inotify_init1 called 209
inotify_init1 called 210
inotify_init1 called 211
inotify_init1 called 212
inotify_init1 called 213
inotify_init1 called 214
inotify_init1 called 215
inotify_init1 called 216
inotify_init1 called 217
inotify_init1 called 218
inotify_init1 called 219
inotify_init1 called 220
inotify_init1 called 221
inotify_init1 called 222
inotify_init1 called 223
inotify_init1 called 224
inotify_init1 called 225
inotify_init1 called 226
inotify_init1 called 227
inotify_init1 called 228
inotify_init1 called 229
inotify_init1 called 230
inotify_init1 called 231
inotify_init1 called 232
inotify_init1 called 233
inotify_init1 called 234
inotify_init1 called 235
inotify_init1 called 236
inotify_init1 called 237
inotify_init1 called 238
inotify_init1 called 239
inotify06    1  TBROK  :  inotify06.c:105: inotify_init failed: errno=EMFILE(24): Too many open files
inotify06    2  TBROK  :  inotify06.c:105: Remaining cases broken
inotify06    1  TBROK  :  safe_macros.c:370: inotify06.c:96: unlink(fname_1) failed: errno=ENOENT(2): No such file or directory
inotify06    2  TBROK  :  safe_macros.c:370: Remaining cases broken
-------------- next part --------------
[ 1008.337077] lege inotify_new_group ffff88007498b880 0
[ 1008.337334] lege inotify_new_group ffff88007498b880 1
[ 1008.337351] lege inotify_new_group ffff88007498b880 2
[ 1008.337377] lege inotify_new_group ffff88007498b880 3
[ 1008.337394] lege inotify_new_group ffff88007498b880 4
[ 1008.337408] lege inotify_new_group ffff88007498b880 5
[ 1008.337422] lege inotify_new_group ffff88007498b880 6
[ 1008.337436] lege inotify_new_group ffff88007498b880 7
[ 1008.337462] lege inotify_new_group ffff88007498b880 8
[ 1008.337479] lege inotify_new_group ffff88007498b880 9
[ 1008.337506] lege inotify_new_group ffff88007498b880 10
[ 1008.337522] lege inotify_new_group ffff88007498b880 11
[ 1008.337549] lege inotify_new_group ffff88007498b880 12
[ 1008.337580] lege inotify_new_group ffff88007498b880 13
[ 1008.337595] lege inotify_new_group ffff88007498b880 14
[ 1008.337620] lege inotify_new_group ffff88007498b880 15
[ 1008.337687] lege inotify_new_group ffff88007498b880 16
[ 1008.337771] lege inotify_new_group ffff88007498b880 16
[ 1008.337786] lege inotify_new_group ffff88007498b880 17
[ 1008.337799] lege inotify_new_group ffff88007498b880 18
[ 1008.337811] lege inotify_new_group ffff88007498b880 19
[ 1008.337823] lege inotify_new_group ffff88007498b880 20
[ 1008.337837] lege inotify_new_group ffff88007498b880 21
[ 1008.337849] lege inotify_new_group ffff88007498b880 22
[ 1008.337897] lege inotify_new_group ffff88007498b880 23
[ 1008.337914] lege inotify_new_group ffff88007498b880 24
[ 1008.337927] lege inotify_new_group ffff88007498b880 25
[ 1008.337941] lege inotify_new_group ffff88007498b880 26
[ 1008.337954] lege inotify_new_group ffff88007498b880 27
[ 1008.337979] lege inotify_new_group ffff88007498b880 28
[ 1008.337994] lege inotify_new_group ffff88007498b880 29
[ 1008.338009] lege inotify_new_group ffff88007498b880 30
[ 1008.338025] lege inotify_new_group ffff88007498b880 31
[ 1008.338040] lege inotify_new_group ffff88007498b880 32
[ 1008.338055] lege inotify_new_group ffff88007498b880 33
[ 1008.338070] lege inotify_new_group ffff88007498b880 34
[ 1008.338087] lege inotify_new_group ffff88007498b880 35
[ 1008.338106] lege inotify_new_group ffff88007498b880 36
[ 1008.338123] lege inotify_new_group ffff88007498b880 37
[ 1008.338137] lege inotify_new_group ffff88007498b880 38
[ 1008.338150] lege inotify_new_group ffff88007498b880 39
[ 1008.338162] lege inotify_new_group ffff88007498b880 40
[ 1008.338172] lege inotify_new_group ffff88007498b880 40
[ 1008.338182] lege inotify_new_group ffff88007498b880 40
[ 1008.338192] lege inotify_new_group ffff88007498b880 40
[ 1008.338201] lege inotify_new_group ffff88007498b880 40
[ 1008.338211] lege inotify_new_group ffff88007498b880 40
[ 1008.338221] lege inotify_new_group ffff88007498b880 40
[ 1008.338231] lege inotify_new_group ffff88007498b880 40
[ 1008.338241] lege inotify_new_group ffff88007498b880 40
[ 1008.338253] lege inotify_new_group ffff88007498b880 41
[ 1008.338264] lege inotify_new_group ffff88007498b880 42
[ 1008.338276] lege inotify_new_group ffff88007498b880 43
[ 1008.338288] lege inotify_new_group ffff88007498b880 44
[ 1008.338299] lege inotify_new_group ffff88007498b880 45
[ 1008.338311] lege inotify_new_group ffff88007498b880 46
[ 1008.338323] lege inotify_new_group ffff88007498b880 47
[ 1008.338336] lege inotify_new_group ffff88007498b880 48
[ 1008.338348] lege inotify_new_group ffff88007498b880 49
[ 1008.338361] lege inotify_new_group ffff88007498b880 50
[ 1008.338373] lege inotify_new_group ffff88007498b880 51
[ 1008.338387] lege inotify_new_group ffff88007498b880 52
[ 1008.338400] lege inotify_new_group ffff88007498b880 53
[ 1008.338414] lege inotify_new_group ffff88007498b880 54
[ 1008.338428] lege inotify_new_group ffff88007498b880 55
[ 1008.338450] lege inotify_new_group ffff88007498b880 56
[ 1008.338464] lege inotify_new_group ffff88007498b880 57
[ 1008.338479] lege inotify_new_group ffff88007498b880 58
[ 1008.338495] lege inotify_new_group ffff88007498b880 59
[ 1008.338512] lege inotify_new_group ffff88007498b880 60
[ 1008.338527] lege inotify_new_group ffff88007498b880 61
[ 1008.338542] lege inotify_new_group ffff88007498b880 62
[ 1008.338560] lege inotify_new_group ffff88007498b880 63
[ 1008.338576] lege inotify_new_group ffff88007498b880 64
[ 1008.338593] lege inotify_new_group ffff88007498b880 65
[ 1008.338606] lege inotify_new_group ffff88007498b880 66
[ 1008.338618] lege inotify_new_group ffff88007498b880 67
[ 1008.338628] lege inotify_new_group ffff88007498b880 67
[ 1008.338637] lege inotify_new_group ffff88007498b880 67
[ 1008.338648] lege inotify_new_group ffff88007498b880 67
[ 1008.338659] lege inotify_new_group ffff88007498b880 67
[ 1008.338669] lege inotify_new_group ffff88007498b880 67
[ 1008.338678] lege inotify_new_group ffff88007498b880 67
[ 1008.338688] lege inotify_new_group ffff88007498b880 67
[ 1008.338698] lege inotify_new_group ffff88007498b880 67
[ 1008.338710] lege inotify_new_group ffff88007498b880 68
[ 1008.338722] lege inotify_new_group ffff88007498b880 69
[ 1008.338733] lege inotify_new_group ffff88007498b880 70
[ 1008.338745] lege inotify_new_group ffff88007498b880 71
[ 1008.338758] lege inotify_new_group ffff88007498b880 72
[ 1008.338770] lege inotify_new_group ffff88007498b880 73
[ 1008.338785] lege inotify_new_group ffff88007498b880 74
[ 1008.338798] lege inotify_new_group ffff88007498b880 75
[ 1008.338812] lege inotify_new_group ffff88007498b880 76
[ 1008.338825] lege inotify_new_group ffff88007498b880 77
[ 1008.338838] lege inotify_new_group ffff88007498b880 78
[ 1008.338852] lege inotify_new_group ffff88007498b880 79
[ 1008.338888] lege inotify_new_group ffff88007498b880 80
[ 1008.338904] lege inotify_new_group ffff88007498b880 81
[ 1008.338918] lege inotify_new_group ffff88007498b880 82
[ 1008.338933] lege inotify_new_group ffff88007498b880 83
[ 1008.338950] lege inotify_new_group ffff88007498b880 84
[ 1008.338977] lege inotify_new_group ffff88007498b880 85
[ 1008.338993] lege inotify_new_group ffff88007498b880 86
[ 1008.339009] lege inotify_new_group ffff88007498b880 87
[ 1008.339024] lege inotify_new_group ffff88007498b880 88
[ 1008.339042] lege inotify_new_group ffff88007498b880 89
[ 1008.339058] lege inotify_new_group ffff88007498b880 90
[ 1008.339072] lege inotify_new_group ffff88007498b880 91
[ 1008.339085] lege inotify_new_group ffff88007498b880 92
[ 1008.339096] lege inotify_new_group ffff88007498b880 93
[ 1008.339155] lege inotify_new_group ffff88007498b880 94
[ 1008.352021] lege inotify_new_group ffff88007498b880 1
[ 1008.352046] lege inotify_new_group ffff88007498b880 2
[ 1008.352063] lege inotify_new_group ffff88007498b880 3
[ 1008.352079] lege inotify_new_group ffff88007498b880 4
[ 1008.352094] lege inotify_new_group ffff88007498b880 5
[ 1008.352110] lege inotify_new_group ffff88007498b880 6
[ 1008.352124] lege inotify_new_group ffff88007498b880 7
[ 1008.352139] lege inotify_new_group ffff88007498b880 8
[ 1008.352154] lege inotify_new_group ffff88007498b880 9
[ 1008.352170] lege inotify_new_group ffff88007498b880 10
[ 1008.352185] lege inotify_new_group ffff88007498b880 11
[ 1008.352201] lege inotify_new_group ffff88007498b880 12
[ 1008.352216] lege inotify_new_group ffff88007498b880 13
[ 1008.352231] lege inotify_new_group ffff88007498b880 14
[ 1008.352246] lege inotify_new_group ffff88007498b880 15
[ 1008.352261] lege inotify_new_group ffff88007498b880 16
[ 1008.352277] lege inotify_new_group ffff88007498b880 17
[ 1008.352292] lege inotify_new_group ffff88007498b880 18
[ 1008.352307] lege inotify_new_group ffff88007498b880 19
[ 1008.352321] lege inotify_new_group ffff88007498b880 20
[ 1008.352336] lege inotify_new_group ffff88007498b880 21
[ 1008.352351] lege inotify_new_group ffff88007498b880 22
[ 1008.352365] lege inotify_new_group ffff88007498b880 23
[ 1008.352380] lege inotify_new_group ffff88007498b880 24
[ 1008.352396] lege inotify_new_group ffff88007498b880 25
[ 1008.352410] lege inotify_new_group ffff88007498b880 26
[ 1008.352426] lege inotify_new_group ffff88007498b880 27
[ 1008.352440] lege inotify_new_group ffff88007498b880 28
[ 1008.352455] lege inotify_new_group ffff88007498b880 29
[ 1008.352470] lege inotify_new_group ffff88007498b880 30
[ 1008.352484] lege inotify_new_group ffff88007498b880 31
[ 1008.352499] lege inotify_new_group ffff88007498b880 32
[ 1008.352514] lege inotify_new_group ffff88007498b880 33
[ 1008.352529] lege inotify_new_group ffff88007498b880 34
[ 1008.352544] lege inotify_new_group ffff88007498b880 35
[ 1008.352560] lege inotify_new_group ffff88007498b880 36
[ 1008.352575] lege inotify_new_group ffff88007498b880 37
[ 1008.352591] lege inotify_new_group ffff88007498b880 38
[ 1008.352606] lege inotify_new_group ffff88007498b880 39
[ 1008.352620] lege inotify_new_group ffff88007498b880 40
[ 1008.352636] lege inotify_new_group ffff88007498b880 41
[ 1008.352651] lege inotify_new_group ffff88007498b880 42
[ 1008.352667] lege inotify_new_group ffff88007498b880 43
[ 1008.352682] lege inotify_new_group ffff88007498b880 44
[ 1008.352696] lege inotify_new_group ffff88007498b880 45
[ 1008.352712] lege inotify_new_group ffff88007498b880 46
[ 1008.352728] lege inotify_new_group ffff88007498b880 47
[ 1008.352742] lege inotify_new_group ffff88007498b880 48
[ 1008.352757] lege inotify_new_group ffff88007498b880 49
[ 1008.352772] lege inotify_new_group ffff88007498b880 50
[ 1008.352787] lege inotify_new_group ffff88007498b880 51
[ 1008.352802] lege inotify_new_group ffff88007498b880 52
[ 1008.352817] lege inotify_new_group ffff88007498b880 53
[ 1008.352832] lege inotify_new_group ffff88007498b880 54
[ 1008.352848] lege inotify_new_group ffff88007498b880 55
[ 1008.352903] lege inotify_new_group ffff88007498b880 56
[ 1008.352927] lege inotify_new_group ffff88007498b880 57
[ 1008.352942] lege inotify_new_group ffff88007498b880 58
[ 1008.352989] lege inotify_new_group ffff88007498b880 59
[ 1008.353012] lege inotify_new_group ffff88007498b880 60
[ 1008.353034] lege inotify_new_group ffff88007498b880 61
[ 1008.353042] lege inotify_new_group ffff88007498b880 62
[ 1008.353049] lege inotify_new_group ffff88007498b880 63
[ 1008.353056] lege inotify_new_group ffff88007498b880 64
[ 1008.353063] lege inotify_new_group ffff88007498b880 65
[ 1008.353070] lege inotify_new_group ffff88007498b880 66
[ 1008.353078] lege inotify_new_group ffff88007498b880 67
[ 1008.353085] lege inotify_new_group ffff88007498b880 68
[ 1008.353092] lege inotify_new_group ffff88007498b880 69
[ 1008.353101] lege inotify_new_group ffff88007498b880 70
[ 1008.353114] lege inotify_new_group ffff88007498b880 71
[ 1008.353122] lege inotify_new_group ffff88007498b880 72
[ 1008.353130] lege inotify_new_group ffff88007498b880 73
[ 1008.353137] lege inotify_new_group ffff88007498b880 74
[ 1008.353145] lege inotify_new_group ffff88007498b880 75
[ 1008.353152] lege inotify_new_group ffff88007498b880 76
[ 1008.353159] lege inotify_new_group ffff88007498b880 77
[ 1008.353166] lege inotify_new_group ffff88007498b880 78
[ 1008.353173] lege inotify_new_group ffff88007498b880 79
[ 1008.353180] lege inotify_new_group ffff88007498b880 80
[ 1008.353187] lege inotify_new_group ffff88007498b880 81
[ 1008.353195] lege inotify_new_group ffff88007498b880 82
[ 1008.353203] lege inotify_new_group ffff88007498b880 83
[ 1008.353210] lege inotify_new_group ffff88007498b880 84
[ 1008.353216] lege inotify_new_group ffff88007498b880 85
[ 1008.353224] lege inotify_new_group ffff88007498b880 86
[ 1008.353232] lege inotify_new_group ffff88007498b880 87
[ 1008.353239] lege inotify_new_group ffff88007498b880 88
[ 1008.353247] lege inotify_new_group ffff88007498b880 89
[ 1008.353254] lege inotify_new_group ffff88007498b880 90
[ 1008.353261] lege inotify_new_group ffff88007498b880 91
[ 1008.353268] lege inotify_new_group ffff88007498b880 92
[ 1008.353276] lege inotify_new_group ffff88007498b880 93
[ 1008.353283] lege inotify_new_group ffff88007498b880 94
[ 1008.353290] lege inotify_new_group ffff88007498b880 95
[ 1008.353298] lege inotify_new_group ffff88007498b880 96
[ 1008.353305] lege inotify_new_group ffff88007498b880 97
[ 1008.353312] lege inotify_new_group ffff88007498b880 98
[ 1008.353320] lege inotify_new_group ffff88007498b880 99
[ 1008.353327] lege inotify_new_group ffff88007498b880 100
[ 1008.353334] lege inotify_new_group ffff88007498b880 101
[ 1008.353347] lege inotify_new_group ffff88007498b880 102
[ 1008.353354] lege inotify_new_group ffff88007498b880 103
[ 1008.353362] lege inotify_new_group ffff88007498b880 104
[ 1008.353370] lege inotify_new_group ffff88007498b880 105
[ 1008.353377] lege inotify_new_group ffff88007498b880 106
[ 1008.353385] lege inotify_new_group ffff88007498b880 107
[ 1008.353392] lege inotify_new_group ffff88007498b880 108
[ 1008.353399] lege inotify_new_group ffff88007498b880 109
[ 1008.353406] lege inotify_new_group ffff88007498b880 110
[ 1008.353413] lege inotify_new_group ffff88007498b880 111
[ 1008.353421] lege inotify_new_group ffff88007498b880 112
[ 1008.353428] lege inotify_new_group ffff88007498b880 113
[ 1008.353435] lege inotify_new_group ffff88007498b880 114
[ 1008.353443] lege inotify_new_group ffff88007498b880 115
[ 1008.353451] lege inotify_new_group ffff88007498b880 116
[ 1008.353460] lege inotify_new_group ffff88007498b880 117
[ 1008.353467] lege inotify_new_group ffff88007498b880 118
[ 1008.353474] lege inotify_new_group ffff88007498b880 119
[ 1008.353481] lege inotify_new_group ffff88007498b880 120
[ 1008.353488] lege inotify_new_group ffff88007498b880 121
[ 1008.353495] lege inotify_new_group ffff88007498b880 122
[ 1008.353502] lege inotify_new_group ffff88007498b880 123
[ 1008.353509] lege inotify_new_group ffff88007498b880 124
[ 1008.353517] lege inotify_new_group ffff88007498b880 125
[ 1008.353524] lege inotify_new_group ffff88007498b880 126
[ 1008.353531] lege inotify_new_group ffff88007498b880 127
[ 1008.353538] lege inotify_new_group ffff88007498b880 128
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-inotify06-add-debug-code.patch
Type: text/x-patch
Size: 1058 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160418/aeb9b04a/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-inotify-add-debug-code.patch
Type: text/x-patch
Size: 1013 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160418/aeb9b04a/attachment-0003.bin>
