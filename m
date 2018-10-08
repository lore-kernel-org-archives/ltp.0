From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 8 Oct 2018 12:01:56 +0300
Subject: [LTP] [RFC PATCH 4/5] runtest/commands: adjust names for
 keyctl01, sysctl01, unshare01
In-Reply-To: <20181003074240.GB23398@rei>
References: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1536849882-28897-5-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20181002130338.GG24796@rei>
 <bf0bbc7d-e1f8-bad1-b07a-cecfc34ab968@oracle.com>
 <20181003074240.GB23398@rei>
Message-ID: <29edc470-5eca-cd6d-f7ab-8c7a65eb9092@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

On 10/03/2018 10:42 AM, Cyril Hrubis wrote:
> Hi!
>> As if
>>
>> keyctl01 keyctl01.sh
>>
>> was changed to
>>
>> keyctl01_sh keyctl01.sh
>>
>> Correct?
> 
> Or we can, for the cases where command has the same name as syscall,
> increment the numbers for the command tests by 50, that should avoid the
> collisions.
> 
> So the keyctl01.sh will become keyctl51.sh.
> 

Maybe we better stick to your previous proposal, i.e. adding _sh to the
end of a name (in runtest files)? In my opinion, it's more clear and
straightforward, i.e. if one has a look at a runtest file, it will take
little time to understand why some tests have _sh at the end. Plus it
doesn't require renaming of the sh test cases.

Shifting the numbering by a big number looks a bit tricky.
