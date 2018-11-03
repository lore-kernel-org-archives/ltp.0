From: Ramon Pantin <pantin@google.com>
Date: Sat, 3 Nov 2018 15:37:20 -0700
Subject: [LTP] recvmmsg(2) system call tests
In-Reply-To: <20181102105206.GA22411@rei>
References: <ecdea1f2-4931-5dc3-6695-4f8dd78d796d@google.com>
 <20181101113857.GB22042@dell5510>
 <3C276F4D-DC1A-4CB6-A5BC-BBC6B07E23A6@google.com>
 <20181102105206.GA22411@rei>
Message-ID: <9aae07a5-3a03-9da7-d8fd-0326fe3f4cc5@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

About this statemement that you made:

    "Function signatures aren't needed when used just in one file." 

To whch I replied:

    "ARE required unless you reorganize you code to be all in the order
    of called functions preceding called functions"

To which you replied:

    "Actually neither of that is true"

If you don't use prototypes you do have to reorganize the functions in 
the order they are called.

Are you really questioning that? I don't want to have to explain that 
unless you don't understand why prototypes are required in some cases.

If you are not questioning that. Are you ok with me using prototypes?

I don't mind adding static, but do realize that that will indeed mean 
that in some compilation systems the sysmbols won't be in the symbol 
table and will make debugging harder. I don't care if you question this 
statment, don't have time to explain that.

regards,
Ramon Pantin

On 11/02/18 03:52, Cyril Hrubis wrote:
>>>> +int con_receive_iovec_boundary_checks(con_t *conp, int tn, size_t niov);
>>>> +int con_receive_iovec_boundary_checks_peeking(con_t *conp, int tn, size_t niov);
>>>> +int con_receive_file_descriptor(con_t *conp, int tn, int cloexec_flag,
>>>> +				bool some_data, ssize_t controllen_delta);
>>>> +int con_message_too_long_to_fit_might_discard_bytes(con_t *conp, int tn,
>>>> +						    int type);
>>>> +int con_receive_waits_for_message(con_t *conp, int tn);
>>>> +int con_receiver_doesnt_wait_for_messages(con_t *conp, int tn);
>>>> +int con_receive_returns_what_is_available(con_t *conp, int tn);
>>>> +int con_empty_datagram_received_as_empty_datagram(con_t *conp, int tn);
>>> Function signatures aren't needed when used just in one file.
>>> Actually, in this case we declare functions as static.
>> The ARE required unless you reorganize you code to be all in the order of called functions preceding called functions, which is silly. Furthermore if there were mutually recursive functions you couldn???t do that either.
>>
>> Having ???static??? for internal functions only matters if the test program is more than one source file. This is just one file. Its easier to debug when the symbols are visible to the debugger, with some compilers ???static??? functions can not be debugged because the symbols end up not being in the symbol table.
> Actually neither of that is true.
>
> Having static defined tells the compiler that the function is used only
> in the local file, which can for example tell you that some of the
> functions are unused.
>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181103/52884ba9/attachment.html>
