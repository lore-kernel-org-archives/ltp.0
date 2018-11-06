From: Sasha Levin <sashal@kernel.org>
Date: Tue, 6 Nov 2018 12:46:41 -0500
Subject: [LTP] [PATCH 1/1] syscalls/fanotify10: Require kernel v4.19
In-Reply-To: <CAOQ4uxjVnAUYfH8_fuHXruObt1WVqObHxQxLmCxcPCNL-S5PjQ@mail.gmail.com>
References: <20181106124802.27170-1-pvorel@suse.cz>
 <20181106125015.GB4834@rei.lan> <20181106125556.GA28469@dell5510>
 <CAOQ4uxhd9XZj=zvkm1j8mZBkBRw0qhvfwcaRQKzs24bVjsfUZw@mail.gmail.com>
 <20181106130641.GB28469@dell5510>
 <CAOQ4uxjVnAUYfH8_fuHXruObt1WVqObHxQxLmCxcPCNL-S5PjQ@mail.gmail.com>
Message-ID: <20181106174641.GE151445@sasha-vm>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 06, 2018 at 03:32:33PM +0200, Amir Goldstein wrote:
>On Tue, Nov 6, 2018 at 3:06 PM Petr Vorel <pvorel@suse.cz> wrote:
>>
>> Hi Amir,
>>
>> > There must be some confusion.
>> > FAN_MARK_MOUNT was NOT added in v4.19-rc2.
>> > It has been there from the start.
>> > FAN_MARK_INODE was NOT added either
>> > the define FAN_MARK_INODE  0 is just a convenience readability define
>> > it does not change the API.
>> I'm sorry, you're right.
>>
>> > You may be confusing with FAN_MARK_FILESYSTEM
>> > just was just added in kernel v4.20-rc1.
>> > The extension of tests to cover FAN_MARK_FILESYSTEM
>> > is waiting in my queue:
>> > https://github.com/amir73il/ltp/commits/fanotify_sb
>>
>> > And it already includes runtime checks for FAN_MARK_FILESYSTEM
>> > support.
>>
>> > Did I miss anything?
>> Testing your branch on older kernel, fanotify10 fails earlier than new TCONF
>
>Because fanotify10 checks for a bug that existed since the beginning
>and fixed by 9bdda4e9cf2d fsnotify: fix ignore mask logic in fsnotify().
>So test SHOULD fail until the backported patch is applied to the old kernel.
>
>The patch does not apply cleanly to kernels <= v4.17.
>Tested backport patch for v4.14.y attached.

Queued for 4.14, thanks Amir.

--
Thanks,
Sasha
