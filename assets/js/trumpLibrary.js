function isMarALagoOpen(today) {
    dateToday = new Date(today);
    dateMothersDay = new Date(mothersDay(today));
    dateHalloween = new Date(dateToday.getFullYear(), 9, 31);

    return (isBetween(dateToday, dateMothersDay, dateHalloween) ? false : true);
    }
    
