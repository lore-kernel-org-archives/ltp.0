From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 18 Jan 2016 18:03:24 +0300
Subject: [LTP] [PATCH] kernel/input: increase the number of retries in
 open_device
In-Reply-To: <20160118145040.GA5097@rei.lan>
References: <1453128553-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160118145040.GA5097@rei.lan>
Message-ID: <569CFEBC.4080509@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 01/18/2016 05:50 PM, Cyril Hrubis wrote:
> Hi!
>> In some environments the current limit (2) is not enough, and only
>> 3rd or 4th access will succeed. Therefore, let's increase it slightly.
>> The new limit (10) is the same value we have in open_uinput().
>
> Acked. Thanks for the testing :).
>

Thanks, and the example output from my message is not correct ( I 
mistakenly pasted it there), the correct one is:

input01     0  TINFO  :  Trying to load uinput kernel module
input01     0  TINFO  :  Uinput dev not found, retrying...
input01     0  TINFO  :  Uinput dev not found, retrying...
input01     0  TINFO  :  Uinput dev not found, retrying...
input01     0  TINFO  :  Found uinput dev at /dev/uinput
input01     0  TINFO  :  Device not found, retrying...
input01     0  TINFO  :  Device not found, retrying...
input01     1  TBROK  :  input_helper.c:85: Unable to find the input device
input01     2  TBROK  :  input_helper.c:85: Remaining cases broken

:-[

Committed.
