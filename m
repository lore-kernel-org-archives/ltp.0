From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Date: Wed, 11 Nov 2015 09:29:31 +0900
Subject: [LTP] [PATCH] change /test/aiodio to TMPDIR in
	runtest/ltp-aio-stress.partX
In-Reply-To: <20151110150106.GK23947@rei>
References: <563C3B3D.1060809@jp.fujitsu.com> <20151110150106.GK23947@rei>
Message-ID: <56428BEB.1030404@jp.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On Tue, 10 Nov 2015 16:01:06 +0100 Cyril Hrubis wrote:
> Hi!
>> +ADS1000 aio-stress -I500  -o2 -S -r4   $TMPDIR/file1
>> +ADS1001 aio-stress -I500  -o2 -S -r8   $TMPDIR/file1
>> +ADS1002 aio-stress -I500  -o2 -S -r16  $TMPDIR/file1
>> +ADS1003 aio-stress -I500  -o2 -S -r32  -t2  $TMPDIR/junkfile $TMPDIR/file2
>> +ADS1004 aio-stress -I500  -o2 -S -r64   $TMPDIR/junkfile $TMPDIR/file2
>> +ADS1005 aio-stress -I500  -o3 -S -r4    $TMPDIR/junkfile $TMPDIR/file2
>> +ADS1006 aio-stress -I500  -o3 -S -r8   -t2  $TMPDIR/junkfile $TMPDIR/file2
>> +ADS1007 aio-stress -I500  -o3 -S -r16  -t2  $TMPDIR/junkfile $TMPDIR/file2
>> +ADS1008 aio-stress -I500  -o3 -S -r32  -t4  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file3  $TMPDIR/file4
>> +ADS1009 aio-stress -I500  -o3 -S -r64  -t4  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file3  $TMPDIR/file4
>> +ADS1010 aio-stress -I500  -o3 -S -r128 -t4  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file3  $TMPDIR/file4
>> +ADS1011 aio-stress -I500  -o3 -S -r256 -t8  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file3  $TMPDIR/file4 $TMPDIR/file5  $TMPDIR/file6 $TMPDIR/file7  $TMPDIR/file8
>> +ADS1012 aio-stress -I500  -o3 -S -r512 -t8  $TMPDIR/junkfile $TMPDIR/file2 $TMPDIR/file3  $TMPDIR/file4 $TMPDIR/file5  $TMPDIR/file6 $TMPDIR/file7  $TMPDIR/file8
>> +ADS1013 aio-stress -I500  -o2 -O -r4    -t8  $TMPDIR/junkfile $TMPDIR/file2 $TMPDIR/file3  $TMPDIR/file4 $TMPDIR/file5  $TMPDIR/file6 $TMPDIR/file7  $TMPDIR/file8
>> +ADS1014 aio-stress -I500  -o2 -O -r8         $TMPDIR/file1 $TMPDIR/file2
>> +ADS1015 aio-stress -I500  -o2 -O -r16        $TMPDIR/file1 $TMPDIR/file2
>> +ADS1016 aio-stress -I500  -o2 -O -r32   -t2  $TMPDIR/junkfile $TMPDIR/file2
>> +ADS1017 aio-stress -I500  -o2 -O -r64   -t2  $TMPDIR/junkfile $TMPDIR/file2
>> +ADS1018 aio-stress -I500  -o3 -O -r4    -t2  $TMPDIR/junkfile $TMPDIR/file2
>> +ADS1019 aio-stress -I500  -o3 -O -r8    -t2  $TMPDIR/junkfile $TMPDIR/file2
>> +ADS1020 aio-stress -I500  -o3 -O -r16   -t2  $TMPDIR/junkfile $TMPDIR/file2
>> +ADS1021 aio-stress -I500  -o3 -O -r32   -t4  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8
>> +ADS1022 aio-stress -I500  -o3 -O -r64   -t4  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8
>> +ADS1023 aio-stress -I500  -o3 -O -r128  -t4  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8
>> +ADS1024 aio-stress -I500  -o3 -O -r256  -t8  $TMPDIR/junkfile $TMPDIR/file2  $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file4  $TMPDIR/file3  $TMPDIR/file5  $TMPDIR/file6
>> +ADS1025 aio-stress -I500  -o3 -O -r512  -t8  $TMPDIR/junkfile $TMPDIR/file2 $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file3  $TMPDIR/file4  $TMPDIR/file5  $TMPDIR/file6
>> +ADS1026 aio-stress -I500  -o0 -S -r4    -t8  $TMPDIR/junkfile $TMPDIR/file2       $TMPDIR/file7  $TMPDIR/file8 $TMPDIR/file3  $TMPDIR/file4  $TMPDIR/file5  $TMPDIR/file6
>
> ADS1027 to ADS1029 are missing here and therefore the number of changed
> lines does not add up to the numbers between @@ @@ in the header.
>
> Can you please generate working patch and resend it?
>

Thank you for pointing it out!
I will resend it.

Regards,
Masayoshi Mizuma
